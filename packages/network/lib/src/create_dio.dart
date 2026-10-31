import 'package:dio/dio.dart';

import 'auth/session_events.dart';
import 'auth/token_store.dart';
import 'connectivity/connectivity_service.dart';
import 'debug/debug_network_controls.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/connectivity_interceptor.dart';
import 'interceptors/log_interceptor.dart';
import 'interceptors/refresh_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

export 'interceptors/refresh_interceptor.dart' show RefreshCall;
export 'interceptors/retry_interceptor.dart' show NetworkLog, RetryOptions;

class NetworkConfig {
  const NetworkConfig({
    required this.baseUrl,
    required this.tokens,
    required this.connectivity,
    required this.sessionEvents,
    required this.refresh,
    this.retry = const RetryOptions(),
    this.timeout = const Duration(seconds: 15),
    this.log,
    this.debugControls,
  });

  final String baseUrl;
  final TokenStore tokens;
  final ConnectivityService connectivity;
  final SessionEvents sessionEvents;
  final RefreshCall refresh;
  final RetryOptions retry;
  final Duration timeout;

  /// Set in debug builds to log every attempt.
  final NetworkLog? log;

  /// Set in debug builds to fake failures. Never set it in release.
  final DebugNetworkControls? debugControls;
}

/// Builds a Dio with the full chain. The order matters.
///
/// Requests flow top to bottom and errors flow in the same order:
///
///  1. connectivity  refuses while offline, probes after a connection error
///  2. auth          attaches the bearer token
///  3. log           records each raw attempt (debug)
///  4. debug         fakes failures (debug)
///  5. retry         backs off on connection errors, timeouts and 5xx
///  6. refresh       on a 401, refreshes once and replays the request
///
/// Retry and refresh each replay through `dio.fetch`, which restarts the
/// chain. Retry ignores 401 and refresh ignores everything else, so a
/// connection retry never refreshes and a replay after refresh is marked and
/// never refreshes again. Offline refusals are never retried.
Dio createDio(NetworkConfig config) {
  final options = BaseOptions(
    baseUrl: config.baseUrl,
    connectTimeout: config.timeout,
    sendTimeout: config.timeout,
    receiveTimeout: config.timeout,
    headers: {'Accept': 'application/json'},
  );
  final dio = Dio(options);
  final refreshDio = Dio(options.copyWith());
  final log = config.log;
  if (log != null) refreshDio.interceptors.add(NetworkLogInterceptor(log));

  dio.interceptors.addAll([
    ConnectivityInterceptor(config.connectivity),
    AuthInterceptor(config.tokens),
    if (log != null) NetworkLogInterceptor(log),
    if (config.debugControls != null) config.debugControls!.interceptor,
    RetryInterceptor(dio, options: config.retry, log: log),
    RefreshInterceptor(
      dio: dio,
      refreshDio: refreshDio,
      tokens: config.tokens,
      refresh: config.refresh,
      events: config.sessionEvents,
      log: log,
    ),
  ]);
  return dio;
}
