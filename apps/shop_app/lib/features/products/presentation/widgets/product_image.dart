import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

/// Network image that fades in, shows a surface while loading and degrades to
/// an icon when it cannot be fetched.
class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.url, this.radius = 16});

  final String url;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: ColoredBox(
        color: AppColors.surfaceRaised,
        child: SizedBox.expand(
          child: Image.network(
            url,
            fit: BoxFit.cover,
            frameBuilder: (context, child, frame, sync) => AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: sync || frame != null ? 1 : 0,
              child: child,
            ),
            errorBuilder: (context, error, stack) => const Center(
              child: AppIcon(
                LucideIcons.imageOff,
                size: 28,
                color: AppColors.textTertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
