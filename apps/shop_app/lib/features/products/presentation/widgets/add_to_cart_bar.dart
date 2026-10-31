import 'package:context_watch/context_watch.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../../../core/provider_scope.dart';
import '../../../cart/cart_providers.dart';
import '../../domain/product.dart';
import 'price_text.dart';

/// Sticky bottom bar. An "Add to cart" button swaps for a quantity stepper
/// once the product is in the cart, and back when the quantity reaches zero.
class AddToCartBar extends StatelessWidget {
  const AddToCartBar({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    final quantity = context
        .read(cartQuantityProvider(product.id))
        .watch(context);
    final cart = context.read(cartRepositoryProvider);
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x000A0C11), AppColors.background],
          stops: [0, 0.35],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.xl,
          AppSpacing.xl,
          AppSpacing.m + bottom,
        ),
        child: AnimatedSize(
          duration: reduce ? Duration.zero : const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          child: AnimatedSwitcher(
            duration: reduce
                ? Duration.zero
                : const Duration(milliseconds: 240),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween(begin: 0.96, end: 1.0).animate(animation),
                child: child,
              ),
            ),
            child: quantity == 0
                ? AppButton(
                    key: const ValueKey('add'),
                    label: product.stock > 0 ? 'Add to cart' : 'Out of stock',
                    icon: LucideIcons.shoppingCart,
                    onPressed: product.stock > 0
                        ? () => cart.add(product)
                        : null,
                  )
                : _InCart(
                    key: const ValueKey('stepper'),
                    product: product,
                    quantity: quantity,
                    onChanged: (q) => cart.setQuantity(product.id, q),
                  ),
          ),
        ),
      ),
    );
  }
}

class _InCart extends StatelessWidget {
  const _InCart({
    super.key,
    required this.product,
    required this.quantity,
    required this.onChanged,
  });

  final Product product;
  final int quantity;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final unit = product.hasDiscount ? product.discountedPrice : product.price;
    return Row(
      children: [
        Expanded(
          child: Semantics(
            liveRegion: true,
            container: true,
            label: 'Added to cart. $quantity in cart',
            excludeSemantics: true,
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.success.withValues(alpha: 0.14),
                    border: Border.all(
                      color: AppColors.success.withValues(alpha: 0.45),
                    ),
                  ),
                  child: const Center(
                    child: AppIcon(
                      LucideIcons.check,
                      size: 16,
                      color: AppColors.success,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.m),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText('In cart', style: AppTextStyles.bodyStrong),
                      AppText(
                        '${formatPrice(unit)} each',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        QuantityStepper(
          quantity: quantity,
          canIncrement: quantity < product.stock,
          onIncrement: () => onChanged(quantity + 1),
          onDecrement: () => onChanged(quantity - 1),
        ),
      ],
    );
  }
}
