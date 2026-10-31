import 'package:network/network.dart';

import 'failure.dart';

/// Turns whatever a data source threw into the typed [Failure] hierarchy.
/// Repositories call it once, so widgets and controllers never see Dio.
Failure failureFromError(Object error) {
  if (error is Failure) return error;
  if (error is! DioException) return const UnknownFailure();
  if (error.error is OfflineException) return const OfflineFailure();
  if (error.error is SessionExpiredException) {
    return const UnauthorizedFailure();
  }
  return switch (error.type) {
    DioExceptionType.connectionError ||
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout => const OfflineFailure(),
    DioExceptionType.receiveTimeout => const ServerFailure(),
    DioExceptionType.badResponse => switch (error.response?.statusCode) {
      401 => const UnauthorizedFailure(),
      _ => const ServerFailure(),
    },
    _ => const UnknownFailure(),
  };
}
