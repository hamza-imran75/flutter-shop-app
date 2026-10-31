import 'package:flutter/widgets.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_spacing.dart';
import '../typography/app_text_styles.dart';
import 'app_icon.dart';
import 'app_spinner.dart';
import 'pressable.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool loading;
  final bool expand;

  static const _radius = BorderRadius.all(Radius.circular(AppRadii.m));

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !loading;
    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      excludeSemantics: true,
      child: Pressable(
        onTap: enabled ? onPressed : null,
        builder: (context, pressed) => AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: onPressed == null && !loading ? 0.5 : 1,
          child: _Surface(
            pressed: pressed,
            expand: expand,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 160),
                  opacity: loading ? 0 : 1,
                  child: _Content(label: label, icon: icon),
                ),
                if (loading) const AppSpinner(size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Surface extends StatelessWidget {
  const _Surface({
    required this.pressed,
    required this.expand,
    required this.child,
  });

  final double pressed;
  final bool expand;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppButton._radius,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBottom.withValues(alpha: 0.28),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: AppButton._radius,
        child: Stack(
          children: [
            Container(
              height: 48,
              width: expand ? double.infinity : null,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
              alignment: expand ? Alignment.center : null,
              decoration: const BoxDecoration(
                borderRadius: AppButton._radius,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.primaryTop, AppColors.primaryBottom],
                ),
              ),
              child: child,
            ),
            const Positioned(
              top: 0,
              left: 10,
              right: 10,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0x00FFFFFF),
                      Color(0x59FFFFFF),
                      Color(0x00FFFFFF),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.14 * pressed),
                    borderRadius: AppButton._radius,
                    border: Border.all(
                      color: AppColors.primaryBorder.withValues(alpha: 0.85),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.label, required this.icon});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          AppIcon(icon!, size: 18),
          const SizedBox(width: AppSpacing.s),
        ],
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.label.copyWith(color: const Color(0xFFFFFFFF)),
          ),
        ),
      ],
    );
  }
}
