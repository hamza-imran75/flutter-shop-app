abstract final class AppConfig {
  static const apiBaseUrl = 'https://dummyjson.com';

  /// Lifetime requested for access tokens. A short value makes the refresh
  /// flow easy to watch: `--dart-define=ACCESS_TOKEN_MINS=1`.
  static const accessTokenMins = int.fromEnvironment(
    'ACCESS_TOKEN_MINS',
    defaultValue: 60,
  );
}
