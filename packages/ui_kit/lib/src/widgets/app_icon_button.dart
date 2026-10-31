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
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      excludeSemantics: true,
      child: Pressable(
        onTap: onPressed,
        pressedScale: 0.92,
        builder: (context, pressed) => Container(
          width: 40,
          height: 40,
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
    );
  }
}
