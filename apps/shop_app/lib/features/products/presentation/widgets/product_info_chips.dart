import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

class InfoChip extends StatelessWidget {
  const InfoChip({super.key, required this.label, this.color});

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tint = color ?? AppColors.textSecondary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color == null
            ? AppColors.surfaceRaised
            : tint.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(
          color: color == null
              ? AppColors.border
              : tint.withValues(alpha: 0.35),
        ),
      ),
      child: Text(label, style: AppTextStyles.caption.copyWith(color: tint)),
    );
  }
}

class StockChip extends StatelessWidget {
  const StockChip({super.key, required this.stock});

  final int stock;

  @override
  Widget build(BuildContext context) {
    if (stock <= 0) {
      return const InfoChip(label: 'Out of stock', color: AppColors.danger);
    }
    if (stock <= 10) {
      return InfoChip(label: 'Only $stock left', color: AppColors.warning);
    }
    return const InfoChip(label: 'In stock', color: AppColors.success);
  }
}
