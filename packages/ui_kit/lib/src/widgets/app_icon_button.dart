import 'package:flutter/widgets.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_spacing.dart';
import 'app_icon.dart';
import 'pressable.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
    this.size = 40,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String semanticLabel;

  /// Visual size. The tap target never drops below [minTapTarget].
  final double size;

  static const minTapTarget = 44.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      excludeSemantics: true,
      child: Pressable(
        onTap: onPressed,
        pressedScale: 0.92,
        builder: (context, pressed) => SizedBox(
          width: minTapTarget,
          height: minTapTarget,
          child: Center(
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Color.lerp(
                  AppColors.surfaceRaised,
                  const Color(0xFF242A38),
                  pressed,
                ),
                borderRadius: BorderRadius.circular(AppRadii.m),
                border: Border.all(color: AppColors.border),
              ),
              child: Center(child: AppIcon(icon, size: 18)),
            ),
          ),
        ),
      ),
    );
  }
}
