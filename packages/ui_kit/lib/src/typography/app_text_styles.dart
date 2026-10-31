import 'package:flutter/painting.dart';

import '../tokens/app_colors.dart';

/// Inter ships as a variable font, so the weight axis is set explicitly.
abstract final class AppTextStyles {
  static TextStyle _inter(
    double size,
    int weight, {
    double? height,
    double letterSpacing = 0,
    Color color = AppColors.textPrimary,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      package: 'ui_kit',
      fontSize: size,
      fontWeight: FontWeight.values[(weight ~/ 100) - 1],
      fontVariations: [FontVariation('wght', weight.toDouble())],
      height: height,
      letterSpacing: letterSpacing,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static final display = _inter(32, 700, height: 1.15, letterSpacing: -0.8);
  static final title = _inter(22, 700, height: 1.2, letterSpacing: -0.4);
  static final heading = _inter(17, 600, height: 1.3, letterSpacing: -0.2);
  static final body = _inter(15, 400, height: 1.45);
  static final bodyStrong = _inter(15, 600, height: 1.4);
  static final label = _inter(15, 500, height: 1.2);
  static final caption = _inter(
    13,
    500,
    height: 1.3,
    color: AppColors.textSecondary,
  );
  static final micro = _inter(11, 600, height: 1.2, letterSpacing: 0.2);
}
