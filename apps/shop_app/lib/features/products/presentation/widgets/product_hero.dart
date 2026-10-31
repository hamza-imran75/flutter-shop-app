import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../domain/product.dart';

/// The shared image flight between list and detail, skipped when the system
/// asks for reduced motion.
class ProductHero extends StatelessWidget {
  const ProductHero({super.key, required this.product, required this.child});

  final Product product;
  final Widget child;

  @override
  Widget build(BuildContext context) => context.reduceMotion
      ? child
      : Hero(tag: 'product-image-${product.id}', child: child);
}
