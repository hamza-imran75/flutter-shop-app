import 'package:context_watch/context_watch.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_kit/ui_kit.dart';

import '../cart_providers.dart';
import 'cart_controller.dart';
import 'cart_state.dart';
import 'widgets/cart_line_tile.dart';
import 'widgets/cart_summary.dart';
import 'widgets/order_placed_view.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      _CartView(controller: ref.watch(cartControllerProvider));
}

class _CartView extends StatelessWidget {
  const _CartView({required this.controller});

  final CartController controller;

  @override
  Widget build(BuildContext context) {
    final state = controller.watch(context);
    final padding = MediaQuery.paddingOf(context);
    return ColoredBox(
      color: AppColors.background,
      child: Column(
        children: [
          SizedBox(height: padding.top),
          _Header(state: state),
          Expanded(child: FadeSwitcher(child: _body(context, state))),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, CartState state) {
    return switch (state) {
      CartEmpty() => EmptyView(
        key: const ValueKey('empty'),
        icon: LucideIcons.shoppingBag,
        title: 'Your cart is empty',
        message: 'Products you add will show up here.',
        actionLabel: 'Browse products',
        onAction: () => Navigator.of(context).pop(),
      ),
      CartReview() => _Review(
        key: const ValueKey('review'),
        state: state,
        controller: controller,
      ),
      CartPlaced() => OrderPlacedView(
        key: const ValueKey('placed'),
        state: state,
        onDone: () => Navigator.of(context).pop(),
      ),
    };
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.state});

  final CartState state;

  @override
  Widget build(BuildContext context) {
    final count = state is CartReview
        ? (state as CartReview).cart.itemCount
        : 0;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.l,
        AppSpacing.m,
        AppSpacing.l,
        AppSpacing.s,
      ),
      child: Row(
        children: [
          AppIconButton(
            icon: LucideIcons.arrowLeft,
            semanticLabel: 'Back',
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText('Cart', style: AppTextStyles.title),
                if (count > 0)
                  AppText(
                    '$count ${count == 1 ? 'item' : 'items'}',
                    style: AppTextStyles.caption,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Review extends StatelessWidget {
  const _Review({super.key, required this.state, required this.controller});

  final CartReview state;
  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.l,
              AppSpacing.s,
              AppSpacing.l,
              AppSpacing.l,
            ),
            children: [
              for (final line in state.cart.lines)
                CartLineTile(
                  key: ValueKey(line.product.id),
                  line: line,
                  enabled: !state.checkingOut,
                  onQuantity: (q) => controller.setQuantity(line.product.id, q),
                  onRemove: () => controller.remove(line.product.id),
                ),
            ],
          ),
        ),
        CartSummary(
          cart: state.cart,
          checkingOut: state.checkingOut,
          onCheckout: controller.checkout,
        ),
      ],
    );
  }
}
