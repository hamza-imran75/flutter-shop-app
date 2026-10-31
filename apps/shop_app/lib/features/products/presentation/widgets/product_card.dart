import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_kit/ui_kit.dart';

import 'package:context_watch/context_watch.dart';

import '../../../cart/cart_providers.dart';
import '../../../cart/presentation/widgets/in_cart_chip.dart';
import '../../domain/product.dart';
import 'price_text.dart';
import 'product_hero.dart';
import 'product_image.dart';
import 'rating_label.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(cartQuantityProvider(product.id)).watch(context);
    return Semantics(
      button: true,
      label: _label(quantity),
      excludeSemantics: true,
      child: Pressable(
        onTap: onTap,
        pressedScale: 0.98,
        builder: (context, _) => DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadii.l + 2),
            border: Border.all(color: AppColors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ProductHero(
                        product: product,
                        child: ProductImage(
                          url: product.cover,
                          radius: AppRadii.l - 2,
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: InCartChip(quantity: quantity),
                      ),
                      if (product.hasDiscount)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: _DiscountBadge(
                            percent: product.discountPercentage,
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 10, 6, 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (product.brand ?? product.category).toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.micro.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          height: 1.25,
                          fontVariations: const [FontVariation('wght', 550)],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: PriceText(
                              product: product,
                              showOriginal: false,
                            ),
                          ),
                          RatingLabel(rating: product.rating),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on ProductCard {
  String _label(int quantity) => [
    product.title,
    ?product.brand,
    formatPrice(product.hasDiscount ? product.discountedPrice : product.price),
    if (product.hasDiscount)
      '${product.discountPercentage.round()} percent off',
    'rated ${product.rating.toStringAsFixed(1)} out of 5',
    if (quantity > 0) 'in cart ×$quantity',
  ].join(', ');
}

class _DiscountBadge extends StatelessWidget {
  const _DiscountBadge({required this.percent});

  final double percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.5)),
      ),
      child: Text(
        '-${percent.round()}%',
        style: AppTextStyles.micro.copyWith(color: AppColors.success),
      ),
    );
  }
}
