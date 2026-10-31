import 'package:context_watch/context_watch.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import '../core/provider_scope.dart';
import '../features/auth/auth_providers.dart';
import '../features/auth/presentation/auth_state.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/products/presentation/products_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderBuilder(
      provider: authControllerProvider,
      builder: (context, auth) {
        final state = auth.watch(context);
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
      },
    );
  }
}
