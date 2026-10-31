import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/connectivity_status.dart';
import '../domain/auth_repository.dart';
import 'auth_state.dart';

class AuthController extends ValueNotifier<AuthState> {
  AuthController(this._repository, this._connectivity)
    : super(const AuthRestoring()) {
    _sessionExpired = _repository.sessionExpired.listen(
      (_) => value = const AuthSignedOut(),
    );
  }

  final AuthRepository _repository;
  final ConnectivityStatus _connectivity;
  late final StreamSubscription<void> _sessionExpired;

  /// Validates the stored session, waiting out a lost connection. Any other
  /// failure lands on the login screen and keeps the stored tokens, so the
  /// next launch tries again.
  Future<void> restore() async {
    try {
      final session = await retryWhenOnline(
        _connectivity,
        _repository.restoreSession,
      );
      value = session == null ? const AuthSignedOut() : AuthSignedIn(session);
    } catch (_) {
      value = const AuthSignedOut();
    }
  }

  /// Throws the repository's [Failure] so the form can show it inline.
  Future<void> signIn(String username, String password) async {
    final session = await _repository.login(
      username: username,
      password: password,
    );
    value = AuthSignedIn(session);
  }

  Future<void> signOut() async {
    await _repository.logout();
    value = const AuthSignedOut();
  }

  @override
  void dispose() {
    _sessionExpired.cancel();
    super.dispose();
  }
}
