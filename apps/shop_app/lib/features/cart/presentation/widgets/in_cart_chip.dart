import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

/// "In cart ×N" marker for a product card. Takes no space at zero. The card
/// announces the quantity itself, so the chip stays out of semantics.
class InCartChip extends StatelessWidget {
  const InCartChip({super.key, required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: context.motion(const Duration(milliseconds: 220)),
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
                    Flexible(
                      child: Text(
                        'In cart ×$quantity',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.micro.copyWith(
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
