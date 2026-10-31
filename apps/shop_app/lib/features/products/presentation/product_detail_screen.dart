import 'package:context_watch/context_watch.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../../core/provider_scope.dart';
import '../domain/product.dart';
import '../products_providers.dart';
import 'widgets/add_to_cart_bar.dart';
import 'widgets/image_carousel.dart';
import 'widgets/price_text.dart';
import 'widgets/product_info_chips.dart';
import 'widgets/rating_label.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ProviderBuilder(
      provider: productDetailControllerProvider(product),
      builder: (context, controller) => _DetailView(controller: controller),
    );
  }
}

class _DetailView extends StatelessWidget {
  const _DetailView({required this.controller});

  final ValueNotifier<Product> controller;

  @override
  Widget build(BuildContext context) {
    final product = controller.watch(context);
    final padding = MediaQuery.paddingOf(context);

    return ColoredBox(
      color: AppColors.background,
      child: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                top: padding.top + 64,
                bottom: padding.bottom + 112,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageCarousel(product: product),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      AppSpacing.xl,
                      AppSpacing.xl,
                      0,
                    ),
                    child: _Info(product: product),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: padding.top + AppSpacing.m,
            left: AppSpacing.l,
            child: AppIconButton(
              icon: LucideIcons.arrowLeft,
              semanticLabel: 'Back',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AddToCartBar(inStock: product.stock > 0),
          ),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.brand != null)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs + 2),
            child: AppText(
              product.brand!.toUpperCase(),
              style: AppTextStyles.micro,
              color: AppColors.accent,
            ),
          ),
        AppText(product.title, style: AppTextStyles.title),
        const SizedBox(height: AppSpacing.m),
        Row(
          children: [
            RatingLabel(rating: product.rating),
            const SizedBox(width: AppSpacing.m),
            Container(
              width: 3,
              height: 3,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(width: AppSpacing.m),
            AppText(_titleCase(product.category), style: AppTextStyles.caption),
          ],
        ),
        const SizedBox(height: AppSpacing.l),
        Row(
          children: [
            PriceText(product: product, large: true),
            const SizedBox(width: AppSpacing.m),
            if (product.hasDiscount)
              InfoChip(
                label: '-${product.discountPercentage.round()}%',
                color: AppColors.success,
              ),
            const Spacer(),
            StockChip(stock: product.stock),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        AppText('About', style: AppTextStyles.heading),
        const SizedBox(height: AppSpacing.s),
        AppText(product.description, color: AppColors.textSecondary),
        if (product.tags.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.s,
            runSpacing: AppSpacing.s,
            children: [
              for (final tag in product.tags) InfoChip(label: '#$tag'),
            ],
          ),
        ],
      ],
    );
  }

  String _titleCase(String slug) => slug
      .split('-')
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');
}
