import 'auth_session.dart';

abstract interface class AuthRepository {
  /// Throws [InvalidCredentialsFailure], [OfflineFailure] or [ServerFailure].
  Future<AuthSession> login({required String username, required String password});

  Future<void> logout();

  Future<AuthSession?> restoreSession();
}
