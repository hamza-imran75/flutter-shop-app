import 'package:dio/dio.dart';

import '../auth/auth_tokens.dart';
import '../auth/session_events.dart';
import '../auth/token_store.dart';
import '../errors.dart';
import '../network_extras.dart';
import 'retry_interceptor.dart';

/// Performs the refresh call. [refreshDio] has no interceptors, so the call
/// cannot recurse into this one. Returns the tokens to store, keeping the old
/// refresh token when the server does not rotate it.
typedef RefreshCall = Future<AuthTokens> Function(
  Dio refreshDio,
  String refreshToken,
);

/// On a 401, refreshes the access token and retries the request once.
///
/// Concurrent 401s share one in-flight refresh. A refresh the server rejects
/// (400, 401, 403) clears the tokens and emits [SessionEvents.expired]. Any
/// other refresh failure, such as a lost connection, leaves the session alone
/// and reaches the caller as a transient error.
class RefreshInterceptor extends Interceptor {
  RefreshInterceptor({
    required this._dio,
    required this._refreshDio,
    required this._tokens,
    required this._refresh,
    required this._events,
    this._log,
  });

  static const _rejectedStatuses = {400, 401, 403};

  final Dio _dio;
  final Dio _refreshDio;
  final TokenStore _tokens;
  final RefreshCall _refresh;
  final SessionEvents _events;
  final NetworkLog? _log;

  Future<void>? _inFlight;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final request = err.requestOptions;
    if (err.response?.statusCode != 401 ||
        request.extra[NetworkExtras.skipAuth] == true ||
        request.extra[NetworkExtras.refreshed] == true) {
      return handler.next(err);
    }
    final current = await _tokens.read();
    if (current == null) return handler.next(err);

    try {
      final inFlight = _inFlight;
      if (inFlight != null) {
        await inFlight;
      } else if (request.headers['Authorization'] ==
          'Bearer ${current.accessToken}') {
        await _startRefresh();
      }
    } on SessionExpiredException {
      return handler.reject(
        DioException(
          requestOptions: request,
          response: err.response,
          type: DioExceptionType.badResponse,
          error: const SessionExpiredException(),
        ),
      );
    } on DioException catch (e) {
      return handler.reject(e);
    }

    request.extra[NetworkExtras.refreshed] = true;
    request.headers.remove('Authorization');
    try {
      handler.resolve(await _dio.fetch<dynamic>(request));
    } on DioException catch (e) {
      handler.reject(e);
    }
  }

  Future<void> _startRefresh() =>
      _inFlight = _refreshOnce().whenComplete(() => _inFlight = null);

  Future<void> _refreshOnce() async {
    final stored = await _tokens.read();
    if (stored == null) throw const SessionExpiredException();
    _log?.call('refresh: requesting new tokens');
    try {
      final fresh = await _refresh(_refreshDio, stored.refreshToken);
      await _tokens.write(fresh);
      _log?.call('refresh: ok');
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (_rejectedStatuses.contains(status)) {
        await _tokens.clear();
        _events.emitExpired();
        _log?.call('refresh: rejected ($status), session cleared');
        throw const SessionExpiredException();
      }
      _log?.call('refresh: failed (${e.type.name}), session kept');
      rethrow;
    }
  }
}
