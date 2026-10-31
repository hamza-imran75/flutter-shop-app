import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../domain/product.dart';

String formatPrice(double value) => '\$${value.toStringAsFixed(2)}';

class PriceText extends StatelessWidget {
  const PriceText({
    super.key,
    required this.product,
    this.large = false,
    this.showOriginal = true,
  });

  final Product product;
  final bool large;
  final bool showOriginal;

  @override
  Widget build(BuildContext context) {
    final current = product.hasDiscount
        ? product.discountedPrice
        : product.price;
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            formatPrice(current),
            style: large ? AppTextStyles.title : AppTextStyles.bodyStrong,
          ),
          if (product.hasDiscount && showOriginal) ...[
            const SizedBox(width: AppSpacing.s - 2),
            Text(
              formatPrice(product.price),
              style: (large ? AppTextStyles.body : AppTextStyles.caption)
                  .copyWith(
                    color: AppColors.textTertiary,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColors.textTertiary,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
