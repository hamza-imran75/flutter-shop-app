import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import '../auth/token_store.dart';

/// Switches a developer panel flips to produce failures that are hard to
/// trigger on a device. Only ever created in debug builds.
class DebugNetworkControls {
  DebugNetworkControls(this._tokens);

  final TokenStore _tokens;

  /// Read by [ConnectivityService], so the whole app sees an outage.
  final forceOffline = ValueNotifier<bool>(false);
  final failAllWith500 = ValueNotifier<bool>(false);

  int _failNext = 0;
  bool _unauthorizeNext = false;

  void failNextRequests(int count) => _failNext = count;

  void unauthorizeNextRequest() => _unauthorizeNext = true;

  /// The server answers the next authenticated request with a real 401.
  Future<void> corruptAccessToken() async {
    final tokens = await _tokens.read();
    if (tokens == null) return;
    await _tokens.write(tokens.copyWith(accessToken: 'corrupted.access.token'));
  }

  /// The server rejects the next refresh with a real 403.
  Future<void> invalidateRefreshToken() async {
    final tokens = await _tokens.read();
    if (tokens == null) return;
    await _tokens.write(tokens.copyWith(refreshToken: 'invalid.refresh.token'));
  }

  DebugNetworkInterceptor get interceptor => DebugNetworkInterceptor._(this);

  void dispose() {
    forceOffline.dispose();
    failAllWith500.dispose();
  }
}

/// Fakes server answers. It sits first in the chain, so everything behind it
/// (retry, refresh) reacts exactly as it would to a real response.
class DebugNetworkInterceptor extends Interceptor {
  DebugNetworkInterceptor._(this._controls);

  final DebugNetworkControls _controls;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final isAuthenticated = options.headers.containsKey('Authorization');
    if (isAuthenticated && _controls._unauthorizeNext) {
      _controls._unauthorizeNext = false;
      return _fail(options, handler, 401);
    }
    if (_controls.failAllWith500.value || _controls._failNext > 0) {
      if (_controls._failNext > 0) _controls._failNext--;
      return _fail(options, handler, 500);
    }
    handler.next(options);
  }

  void _fail(
    RequestOptions options,
    RequestInterceptorHandler handler,
    int status,
  ) {
    handler.reject(
      DioException.badResponse(
        statusCode: status,
        requestOptions: options,
        response: Response<dynamic>(
          requestOptions: options,
          statusCode: status,
          data: {'message': 'Injected by the debug panel.'},
        ),
      ),
      true,
    );
  }
}
