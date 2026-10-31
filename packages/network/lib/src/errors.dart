/// Carried as `DioException.error` when a request is refused because the
/// device is offline, so no doomed request is sent.
class OfflineException implements Exception {
  const OfflineException();

  @override
  String toString() => 'OfflineException';
}

/// Carried as `DioException.error` when a token refresh was rejected and the
/// stored session was cleared.
class SessionExpiredException implements Exception {
  const SessionExpiredException();

  @override
  String toString() => 'SessionExpiredException';
}
