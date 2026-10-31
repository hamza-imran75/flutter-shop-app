import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';

import '../errors.dart';
import '../network_extras.dart';

typedef NetworkLog = void Function(String message);

class RetryOptions {
  const RetryOptions({
    this.maxRetries = 3,
    this.baseDelay = const Duration(milliseconds: 500),
    this.maxDelay = const Duration(seconds: 8),
  });

  final int maxRetries;
  final Duration baseDelay;
  final Duration maxDelay;
}

/// Retries connection errors, timeouts, 5xx and 429 with exponential backoff
/// and jitter. Idempotent methods only, unless a request opts in through
/// [NetworkExtras.retry]. A retry re-enters the whole interceptor chain, so
/// it sees the connectivity check and a fresh token again.
class RetryInterceptor extends Interceptor {
  RetryInterceptor(
    this._dio, {
    this.options = const RetryOptions(),
    this.log,
    Random? random,
  }) : _random = random ?? Random();

  static const _idempotent = {'GET', 'HEAD', 'PUT', 'DELETE', 'OPTIONS'};

  final Dio _dio;
  final RetryOptions options;
  final NetworkLog? log;
  final Random _random;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final request = err.requestOptions;
    final attempt = (request.extra[NetworkExtras.retryAttempt] as int?) ?? 0;
    final limit =
        (request.extra[NetworkExtras.maxRetries] as int?) ?? options.maxRetries;
    if (attempt >= limit || !_shouldRetry(err)) return handler.next(err);

    final delay = _delayFor(err, attempt);
    log?.call(
      'retry ${attempt + 1}/$limit ${request.method} ${request.uri.path} '
      'in ${delay.inMilliseconds}ms',
    );
    await Future<void>.delayed(delay);
    if (request.cancelToken?.isCancelled ?? false) return handler.next(err);

    request.extra[NetworkExtras.retryAttempt] = attempt + 1;
    try {
      handler.resolve(await _dio.fetch<dynamic>(request));
    } on DioException catch (e) {
      handler.reject(e);
    }
  }

  bool _shouldRetry(DioException err) {
    final request = err.requestOptions;
    final override = request.extra[NetworkExtras.retry];
    if (override == false) return false;
    if (override != true && !_idempotent.contains(request.method)) {
      return false;
    }
    if (err.error is OfflineException || err.error is SessionExpiredException) {
      return false;
    }
    return switch (err.type) {
      DioExceptionType.connectionError ||
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => true,
      DioExceptionType.badResponse =>
        (err.response?.statusCode ?? 0) >= 500 ||
            err.response?.statusCode == 429,
      _ => false,
    };
  }

  Duration _delayFor(DioException err, int attempt) {
    final retryAfter = _retryAfter(err.response);
    if (retryAfter != null) {
      return retryAfter > options.maxDelay ? options.maxDelay : retryAfter;
    }
    final exponential = options.baseDelay * pow(2, attempt).toInt();
    final capped = exponential > options.maxDelay
        ? options.maxDelay
        : exponential;
    // Equal jitter: half fixed, half random, so synchronized clients spread out.
    final half = capped.inMilliseconds ~/ 2;
    return Duration(milliseconds: half + _random.nextInt(half + 1));
  }

  Duration? _retryAfter(Response<dynamic>? response) {
    final status = response?.statusCode;
    if (status != 429 && status != 503) return null;
    final value = response?.headers.value('retry-after');
    if (value == null) return null;
    final seconds = int.tryParse(value);
    if (seconds != null) return Duration(seconds: seconds);
    try {
      final wait = HttpDate.parse(value).difference(DateTime.now());
      return wait.isNegative ? Duration.zero : wait;
    } on HttpException {
      return null;
    }
  }
}
