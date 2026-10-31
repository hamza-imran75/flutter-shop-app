import 'package:flutter/foundation.dart';

import '../../../core/failure.dart';
import 'auth_controller.dart';

sealed class LoginState {
  const LoginState();
}

final class LoginIdle extends LoginState {
  const LoginIdle();
}

final class LoginSubmitting extends LoginState {
  const LoginSubmitting();
}

/// Each failure is a new instance, so the form can react to repeat attempts.
final class LoginFailed extends LoginState {
  LoginFailed(this.failure);

  final Failure failure;
}

class LoginController extends ValueNotifier<LoginState> {
  LoginController(this._auth) : super(const LoginIdle());

  final AuthController _auth;
  bool _disposed = false;

  Future<void> submit(String username, String password) async {
    if (value is LoginSubmitting) return;
    if (username.trim().isEmpty || password.isEmpty) {
      value = LoginFailed(
        const InvalidCredentialsFailure('Enter your username and password.'),
      );
      return;
    }
    value = const LoginSubmitting();
    try {
      await _auth.signIn(username.trim(), password);
    } catch (e) {
      if (!_disposed) value = LoginFailed(e.asFailure());
    }
  }

  void clearError() {
    if (value is LoginFailed) value = const LoginIdle();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
