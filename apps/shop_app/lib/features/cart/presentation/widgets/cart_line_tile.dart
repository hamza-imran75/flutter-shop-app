import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../../products/presentation/widgets/price_text.dart';
import '../../../products/presentation/widgets/product_image.dart';
import '../../domain/cart.dart';

/// One cart row. Removing it, by the bin or by stepping down from one, plays
/// a collapse before the line leaves the cart.
class CartLineTile extends StatefulWidget {
  const CartLineTile({
    super.key,
    required this.line,
    required this.enabled,
    required this.onQuantity,
    required this.onRemove,
  });

  final CartLine line;
  final bool enabled;
  final ValueChanged<int> onQuantity;
  final VoidCallback onRemove;

  @override
  State<CartLineTile> createState() => _CartLineTileState();
}

class _CartLineTileState extends State<CartLineTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _exit = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 260),
    value: 1,
  );
  bool _removing = false;

  @override
  void dispose() {
    _exit.dispose();
    super.dispose();
  }

  Future<void> _remove() async {
    if (_removing || !widget.enabled) return;
    _removing = true;
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (!reduce) await _exit.reverse();
    if (mounted) widget.onRemove();
  }

  void _decrement() {
    final next = widget.line.quantity - 1;
    next <= 0 ? _remove() : widget.onQuantity(next);
  }

  @override
  Widget build(BuildContext context) {
    final line = widget.line;
    final curve = CurvedAnimation(parent: _exit, curve: Curves.easeInOut);
    return SizeTransition(
      sizeFactor: curve,
      alignment: Alignment.topCenter,
      child: FadeTransition(
        opacity: curve,
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.m),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadii.l),
              border: Border.all(color: AppColors.border),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.s),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 84,
                    height: 84,
                    child: ExcludeSemantics(
                      child: ProductImage(
                        url: line.product.cover,
                        radius: AppRadii.m,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.m),
                  Expanded(child: _details(line)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _details(CartLine line) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: AppText(
                  line.product.title,
                  style: AppTextStyles.bodyStrong,
                  maxLines: 2,
                ),
              ),
            ),
            AppIconButton(
              icon: LucideIcons.x,
              semanticLabel: 'Remove ${line.product.title}',
              onPressed: _remove,
              size: 32,
            ),
          ],
        ),
        PriceText(product: line.product, showOriginal: false),
        const SizedBox(height: AppSpacing.s),
        Row(
          children: [
            QuantityStepper(
              quantity: line.quantity,
              canIncrement: line.canIncrement && widget.enabled,
              onIncrement: () => widget.onQuantity(line.quantity + 1),
              onDecrement: _decrement,
            ),
            const Spacer(),
            AppText(formatPrice(line.total), style: AppTextStyles.heading),
          ],
        ),
      ],
    );
  }
}
