import 'package:riverpod/riverpod.dart';

import 'domain/auth_repository.dart';
import 'presentation/auth_controller.dart';
import 'presentation/login_controller.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) =>
      throw UnimplementedError('authRepositoryProvider must be overridden'),
);

final authControllerProvider = Provider<AuthController>((ref) {
  final controller = AuthController(ref.watch(authRepositoryProvider))
    ..restore();
  ref.onDispose(controller.dispose);
  return controller;
});

final loginControllerProvider = Provider.autoDispose<LoginController>((ref) {
  final controller = LoginController(ref.watch(authControllerProvider));
  ref.onDispose(controller.dispose);
  return controller;
});
