import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../../products/presentation/widgets/price_text.dart';
import '../../domain/cart.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({
    super.key,
    required this.cart,
    required this.checkingOut,
    required this.onCheckout,
  });

  final Cart cart;
  final bool checkingOut;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.l,
          AppSpacing.xl,
          AppSpacing.m + bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Row(label: 'Subtotal', value: formatPrice(cart.subtotal)),
            if (cart.savings >= 0.005) ...[
              const SizedBox(height: AppSpacing.s),
              _Row(
                label: 'You save',
                value: '-${formatPrice(cart.savings)}',
                color: AppColors.success,
              ),
            ],
            const SizedBox(height: AppSpacing.m),
            const SizedBox(
              height: 1,
              child: ColoredBox(color: AppColors.border),
            ),
            const SizedBox(height: AppSpacing.m),
            _Row(
              label: 'Total',
              value: formatPrice(cart.total),
              style: AppTextStyles.heading,
            ),
            const SizedBox(height: AppSpacing.l),
            AppButton(
              label: 'Checkout',
              icon: LucideIcons.creditCard,
              loading: checkingOut,
              onPressed: onCheckout,
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.value,
    this.color,
    this.style,
  });

  final String label;
  final String value;
  final Color? color;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final base = style ?? AppTextStyles.body;
    return MergeSemantics(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            label,
            style: base,
            color: color ?? (style == null ? AppColors.textSecondary : null),
          ),
          AppText(value, style: base, color: color),
        ],
      ),
    );
  }
}
