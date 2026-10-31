import '../domain/auth_session.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthRestoring extends AuthState {
  const AuthRestoring();
}

final class AuthSignedOut extends AuthState {
  const AuthSignedOut();
}

final class AuthSignedIn extends AuthState {
  const AuthSignedIn(this.session);

  final AuthSession session;
}
