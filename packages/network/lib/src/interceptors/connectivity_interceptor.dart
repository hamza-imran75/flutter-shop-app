import 'package:dio/dio.dart';

import '../connectivity/connectivity_service.dart';
import '../errors.dart';

/// Fails fast while offline instead of firing a request that cannot succeed.
/// A connection error while the service still says online means the interface
/// is lying, so it triggers a probe before the error moves on.
class ConnectivityInterceptor extends Interceptor {
  ConnectivityInterceptor(this._connectivity);

  final ConnectivityService _connectivity;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_connectivity.isOnline) return handler.next(options);
    handler.reject(
      DioException.connectionError(
        requestOptions: options,
        reason: 'offline',
        error: const OfflineException(),
      ),
      true,
    );
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.error is! OfflineException && _isConnectionFailure(err)) {
      await _connectivity.recheck();
    }
    handler.next(err);
  }
}

bool _isConnectionFailure(DioException e) => switch (e.type) {
  DioExceptionType.connectionError ||
  DioExceptionType.connectionTimeout ||
  DioExceptionType.sendTimeout => true,
  _ => false,
};
