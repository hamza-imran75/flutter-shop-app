import 'package:flutter/widgets.dart';

import '../tokens/app_colors.dart';

/// Renders a Lucide glyph through the widgets-layer [Icon].
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    super.key,
    this.size = 20,
    this.color = AppColors.textPrimary,
  });

  final IconData icon;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => Icon(icon, size: size, color: color);
}
