import 'package:flutter/foundation.dart';

import '../domain/auth_repository.dart';
import 'auth_state.dart';

class AuthController extends ValueNotifier<AuthState> {
  AuthController(this._repository) : super(const AuthRestoring());

  final AuthRepository _repository;

  Future<void> restore() async {
    final session = await _repository.restoreSession();
    value = session == null ? const AuthSignedOut() : AuthSignedIn(session);
  }

  /// Throws the repository's [Failure] so the form can show it inline.
  Future<void> signIn(String username, String password) async {
    final session = await _repository.login(username: username, password: password);
    value = AuthSignedIn(session);
  }

  Future<void> signOut() async {
    await _repository.logout();
    value = const AuthSignedOut();
  }
}
