import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

class RatingLabel extends StatelessWidget {
  const RatingLabel({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AppIcon(LucideIcons.star, size: 13, color: AppColors.warning),
        const SizedBox(width: 3),
        Text(rating.toStringAsFixed(1), style: AppTextStyles.caption),
      ],
    );
  }
}
