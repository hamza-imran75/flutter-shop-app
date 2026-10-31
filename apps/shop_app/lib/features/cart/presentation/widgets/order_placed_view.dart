import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../../products/presentation/widgets/price_text.dart';
import '../cart_state.dart';

class OrderPlacedView extends StatefulWidget {
  const OrderPlacedView({super.key, required this.state, required this.onDone});

  final CartPlaced state;
  final VoidCallback onDone;

  @override
  State<OrderPlacedView> createState() => _OrderPlacedViewState();
}

class _OrderPlacedViewState extends State<OrderPlacedView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduce = context.reduceMotion;
    if (reduce) {
      _pop.value = 1;
    } else if (!_pop.isAnimating && _pop.value == 0) {
      _pop.forward();
    }
  }

  @override
  void dispose() {
    _pop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final items =
        '${state.itemCount} ${state.itemCount == 1 ? 'item' : 'items'}';
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl + 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ExcludeSemantics(
              child: ScaleTransition(
                scale: CurvedAnimation(parent: _pop, curve: Curves.elasticOut),
                child: Container(
                  width: 88,
                  height: 88,
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
                      size: 40,
                      color: AppColors.success,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Semantics(
              liveRegion: true,
              child: AppText(
                'Order placed',
                style: AppTextStyles.title,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppSpacing.s),
            AppText(
              '$items, ${formatPrice(state.total)} total. Thanks for shopping.',
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Continue shopping',
              icon: LucideIcons.arrowLeft,
              expand: false,
              onPressed: widget.onDone,
            ),
          ],
        ),
      ),
    );
  }
}
