import 'package:context_watch/context_watch.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../../../app/app_route.dart';
import '../../../../core/provider_scope.dart';
import '../../cart_providers.dart';
import '../cart_screen.dart';

/// Header button that opens the cart and shows how many items it holds.
class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.read(cartItemCountProvider).watch(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppIconButton(
          icon: LucideIcons.shoppingBag,
          semanticLabel: count == 0
              ? 'Cart, empty'
              : 'Cart, $count ${count == 1 ? 'item' : 'items'}',
          onPressed: () =>
              Navigator.of(context)
                  .push(appRoute<void>((_) => const CartScreen())),
        ),
        Positioned(
          top: -4,
          right: -4,
          child: ExcludeSemantics(
            child: IgnorePointer(child: _Badge(count: count)),
          ),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final reduce = context.reduceMotion;
    return AnimatedSwitcher(
      duration: reduce ? Duration.zero : const Duration(milliseconds: 220),
      switchInCurve: Curves.easeOutBack,
      transitionBuilder: (child, animation) =>
          ScaleTransition(scale: animation, child: child),
      child: count == 0
          ? const SizedBox.shrink(key: ValueKey(0))
          : Container(
              key: ValueKey(count),
              constraints: const BoxConstraints(minWidth: 20),
              height: 20,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadii.pill),
                color: AppColors.primaryTop,
                border: Border.all(color: AppColors.background, width: 2),
              ),
              child: Text(
                count > 99 ? '99+' : '$count',
                style: AppTextStyles.micro.copyWith(
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            ),
    );
  }
}
