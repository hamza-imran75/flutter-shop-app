import 'auth_session.dart';

abstract interface class AuthRepository {
  /// Fires when the server rejected a token refresh and the stored session was
  /// cleared, whatever request caused it.
  Stream<void> get sessionExpired;

  /// Throws [InvalidCredentialsFailure], [OfflineFailure] or [ServerFailure].
  Future<AuthSession> login({
    required String username,
    required String password,
  });

  Future<void> logout();

  /// Validates stored tokens with the server. Null means signed out. Throws
  /// [OfflineFailure] or [ServerFailure] when validation could not happen.
  Future<AuthSession?> restoreSession();
}
