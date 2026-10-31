import 'package:context_watch/context_watch.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../../../core/provider_scope.dart';
import '../../cart_providers.dart';

/// "In cart ×N" marker for a product card. Rebuilds only when this product's
/// quantity changes, and takes no space at zero.
class InCartChip extends StatelessWidget {
  const InCartChip({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    final quantity = context
        .read(cartQuantityProvider(productId))
        .watch(context);
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    return AnimatedSwitcher(
      duration: reduce ? Duration.zero : const Duration(milliseconds: 220),
      switchInCurve: Curves.easeOutBack,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          alignment: Alignment.bottomLeft,
          child: child,
        ),
      ),
      child: quantity == 0
          ? const SizedBox.shrink(key: ValueKey(0))
          : ExcludeSemantics(
              key: ValueKey(quantity),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryBottom,
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                  border: Border.all(color: AppColors.primaryBorder),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppIcon(
                      LucideIcons.check,
                      size: 11,
                      color: Color(0xFFFFFFFF),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'In cart ×$quantity',
                      style: AppTextStyles.micro.copyWith(
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
