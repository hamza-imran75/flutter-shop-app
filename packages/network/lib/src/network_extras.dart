/// Keys for `Options.extra`, the per-request switchboard for the interceptors.
abstract final class NetworkExtras {
  /// `true` skips the bearer header and the refresh flow. Login sets it.
  static const skipAuth = 'network.skipAuth';

  /// `false` disables retries for the request. `true` opts a non-idempotent
  /// method such as POST in.
  static const retry = 'network.retry';

  /// Overrides the configured number of retries for one request.
  static const maxRetries = 'network.maxRetries';

  static const retryAttempt = 'network.retryAttempt';
  static const refreshed = 'network.refreshed';
}
