import 'package:context_watch/context_watch.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../../core/core_providers.dart';
import '../../../core/failure.dart';
import '../../../core/provider_scope.dart';
import '../auth_providers.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderBuilder(
      provider: loginControllerProvider,
      builder: (context, controller) => _LoginView(controller: controller),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView({required this.controller});

  final LoginController controller;

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _passwordFocus = FocusNode();
  bool _obscure = true;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    widget.controller.submit(_username.text, _password.text);
  }

  void _fillDemo() {
    _username.text = 'emilys';
    _password.text = 'emilyspass';
    widget.controller.clearError();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.controller.watch(context);
    final submitting = state is LoginSubmitting;
    final failure = state is LoginFailed ? state.failure : null;
    final inset = MediaQuery.viewInsetsOf(context).bottom;

    // The layout is top-aligned and sized from the screen height without the
    // keyboard, so opening the keyboard never re-centers or moves the content.
    // Only the bottom padding grows, which lets the scroll view reveal a
    // focused field if the keyboard would cover it.
    final topGap = MediaQuery.sizeOf(context).height * 0.05;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(
            AppSpacing.xl,
            topGap,
            AppSpacing.xl,
            AppSpacing.xl + inset,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Brand(onLongPress: _openDevPanel),
              const SizedBox(height: AppSpacing.xxl),
              Shake(
                trigger: state is LoginFailed ? state : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextField(
                      controller: _username,
                      label: 'Username',
                      hint: 'emilys',
                      icon: LucideIcons.user,
                      enabled: !submitting,
                      hasError: failure != null,
                      errorText: failure?.message,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => _passwordFocus.requestFocus(),
                    ),
                    const SizedBox(height: AppSpacing.l),
                    AppTextField(
                      controller: _password,
                      focusNode: _passwordFocus,
                      label: 'Password',
                      hint: 'Your password',
                      icon: LucideIcons.lock,
                      obscureText: _obscure,
                      enabled: !submitting,
                      hasError: failure != null,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _submit(),
                      suffix: _VisibilityToggle(
                        obscured: _obscure,
                        onTap: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                  ],
                ),
              ),
              _ErrorLine(failure: failure),
              const SizedBox(height: AppSpacing.l),
              AppButton(
                label: 'Sign in',
                icon: LucideIcons.logIn,
                loading: submitting,
                onPressed: _submit,
              ),
              const SizedBox(height: AppSpacing.xl),
              _DemoHint(onTap: submitting ? null : _fillDemo),
            ],
          ),
        ),
      ),
    );
  }

  void _openDevPanel() => context.read(devPanelLauncherProvider)?.call(context);
}

class _Brand extends StatelessWidget {
  const _Brand({required this.onLongPress});

  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.l),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.primaryTop, AppColors.primaryBottom],
              ),
              border: Border.all(color: AppColors.primaryBorder),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBottom.withValues(alpha: 0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Center(
              child: AppIcon(LucideIcons.shoppingBag, size: 26),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppText('Welcome back', style: AppTextStyles.display),
          const SizedBox(height: AppSpacing.s),
          AppText(
            'Sign in to browse the catalog.',
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

class _VisibilityToggle extends StatelessWidget {
  const _VisibilityToggle({required this.obscured, required this.onTap});

  final bool obscured;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: obscured ? 'Show password' : 'Hide password',
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Center(
            child: AppIcon(
              obscured ? LucideIcons.eye : LucideIcons.eyeOff,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorLine extends StatelessWidget {
  const _ErrorLine({required this.failure});

  final Failure? failure;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      alignment: Alignment.topCenter,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: failure == null
            ? const SizedBox(width: double.infinity, key: ValueKey('none'))
            : Padding(
                key: ValueKey(failure),
                padding: const EdgeInsets.only(top: AppSpacing.m),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: AppIcon(
                        LucideIcons.circleAlert,
                        size: 16,
                        color: AppColors.danger,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s),
                    Expanded(
                      child: Semantics(
                        liveRegion: true,
                        child: AppText(
                          failure!.message,
                          style: AppTextStyles.caption,
                          color: AppColors.danger,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _DemoHint extends StatelessWidget {
  const _DemoHint({required this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Fill demo credentials, emilys and emilyspass',
      excludeSemantics: true,
      child: Pressable(
        onTap: onTap,
        pressedScale: 0.98,
        builder: (context, _) => Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.l,
            vertical: AppSpacing.m,
          ),
          constraints: const BoxConstraints(minHeight: 44),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadii.m),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const AppIcon(
                LucideIcons.sparkles,
                size: 16,
                color: AppColors.accent,
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: AppText(
                  'Demo account  emilys / emilyspass',
                  style: AppTextStyles.caption,
                ),
              ),
              AppText(
                'Tap to fill',
                style: AppTextStyles.caption,
                color: AppColors.accent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
