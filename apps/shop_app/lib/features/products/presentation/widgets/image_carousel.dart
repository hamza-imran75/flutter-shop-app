import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../../../app/app_route.dart';
import '../image_viewer_screen.dart';

import '../../domain/product.dart';
import 'product_hero.dart';
import 'product_image.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key, required this.product});

  final Product product;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.product.images.isEmpty
        ? [widget.product.thumbnail]
        : widget.product.images;

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PageView.builder(
            controller: _controller,
            itemCount: images.length,
            onPageChanged: (page) => setState(() => _page = page),
            itemBuilder: (context, index) {
              final image = Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
                child: Semantics(
                  image: true,
                  label:
                      '${widget.product.title}, photo ${index + 1} of ${images.length}. Double tap to enlarge',
                  excludeSemantics: true,
                  child: ProductImage(url: images[index], radius: AppRadii.xl),
                ),
              );
              final tappable = GestureDetector(
                onTap: () => Navigator.of(context).push(
                  fadeRoute<void>(
                    (_) =>
                        ImageViewerScreen(images: images, initialIndex: index),
                  ),
                ),
                child: image,
              );
              return index == 0
                  ? ProductHero(product: widget.product, child: tappable)
                  : tappable;
            },
          ),
        ),
        if (images.length > 1) ...[
          const SizedBox(height: AppSpacing.m),
          ExcludeSemantics(
            child: _Dots(count: images.length, index: _page),
          ),
        ],
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == index ? 18 : 6,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.pill),
              color: i == index ? AppColors.primaryTop : AppColors.border,
            ),
          ),
      ],
    );
  }
}
