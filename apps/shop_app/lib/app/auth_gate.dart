import 'package:context_watch/context_watch.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_kit/ui_kit.dart';

import '../features/auth/auth_providers.dart';
import '../features/auth/presentation/auth_state.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/products/presentation/products_screen.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider).watch(context);
    return FadeSwitcher(
      child: switch (state) {
        AuthRestoring() => const Center(
          key: ValueKey('restoring'),
          child: AppSpinner(size: 24, color: AppColors.accent),
        ),
        AuthSignedOut() => const LoginScreen(key: ValueKey('login')),
        AuthSignedIn() => const ProductsScreen(key: ValueKey('products')),
      },
    );
  }
}
