import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_spacing.dart';
import '../typography/app_text_styles.dart';
import 'app_icon.dart';
import 'pressable.dart';

/// Minus, count and plus. At a quantity of one the minus shows a bin, since
/// pressing it removes the item.
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.canIncrement = true,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool canIncrement;

  static const _size = 44.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'Quantity',
      value: '$quantity',
      increasedValue: canIncrement ? '${quantity + 1}' : null,
      decreasedValue: quantity == 1 ? 'Remove' : '${quantity - 1}',
      onIncrease: canIncrement ? onIncrement : null,
      onDecrease: onDecrement,
      excludeSemantics: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surfaceRaised,
          borderRadius: BorderRadius.circular(AppRadii.pill),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _StepButton(
              icon: quantity == 1 ? LucideIcons.trash2 : LucideIcons.minus,
              color: quantity == 1 ? AppColors.danger : AppColors.textPrimary,
              onTap: onDecrement,
            ),
            SizedBox(
              width: 28,
              height: _size,
              child: _Count(quantity: quantity),
            ),
            _StepButton(
              icon: LucideIcons.plus,
              onTap: canIncrement ? onIncrement : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _Count extends StatelessWidget {
  const _Count({required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    return AnimatedSwitcher(
      duration: reduce ? Duration.zero : const Duration(milliseconds: 180),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween(begin: 0.7, end: 1.0).animate(animation),
          child: child,
        ),
      ),
      child: Center(
        key: ValueKey(quantity),
        child: Text('$quantity', style: AppTextStyles.bodyStrong),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.onTap,
    this.color = AppColors.textPrimary,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      pressedScale: 0.88,
      builder: (context, _) => SizedBox(
        width: QuantityStepper._size,
        height: QuantityStepper._size,
        child: Center(
          child: AppIcon(
            icon,
            size: 18,
            color: onTap == null ? AppColors.textTertiary : color,
          ),
        ),
      ),
    );
  }
}
