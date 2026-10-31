import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import 'product_grid.dart';

class ProductGridSkeleton extends StatelessWidget {
  const ProductGridSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Loading products',
      liveRegion: true,
      child: ExcludeSemantics(
        child: Shimmer(
          child: IgnorePointer(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: productGridPadding,
              gridDelegate: productGridDelegate(context),
              itemCount: 8,
              itemBuilder: (context, index) => const _SkeletonCard(),
            ),
          ),
        ),
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.l + 2),
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SkeletonBox(width: double.infinity, radius: AppRadii.l - 2),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(6, 12, 6, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(width: 54, height: 9, radius: 4),
                SizedBox(height: 9),
                SkeletonBox(width: double.infinity, height: 12, radius: 4),
                SizedBox(height: 6),
                SkeletonBox(width: 90, height: 12, radius: 4),
                SizedBox(height: 12),
                SkeletonBox(width: 64, height: 14, radius: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
