import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../../../core/failure.dart';

/// Bottom of the list: a spinner while paging, an inline retry after a failed
/// page, and an end marker once everything is loaded.
class ProductsFooter extends StatelessWidget {
  const ProductsFooter({
    super.key,
    required this.loadingMore,
    required this.hasMore,
    required this.error,
    required this.onRetry,
  });

  final bool loadingMore;
  final bool hasMore;
  final Failure? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.l,
        AppSpacing.s,
        AppSpacing.l,
        AppSpacing.xl + bottom,
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        child: _content(),
      ),
    );
  }

  Widget _content() {
    if (error != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIcon(
            LucideIcons.circleAlert,
            size: 16,
            color: AppColors.danger,
          ),
          const SizedBox(width: AppSpacing.s),
          Flexible(
            child: AppText(
              error is OfflineFailure
                  ? "You're offline."
                  : "Couldn't load more.",
              style: AppTextStyles.caption,
            ),
          ),
          const SizedBox(width: AppSpacing.m),
          Pressable(
            onTap: onRetry,
            builder: (context, _) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.surfaceRaised,
                borderRadius: BorderRadius.circular(AppRadii.pill),
                border: Border.all(color: AppColors.border),
              ),
              child: AppText(
                'Retry',
                style: AppTextStyles.caption,
                color: AppColors.accent,
              ),
            ),
          ),
        ],
      );
    }
    if (loadingMore || hasMore) {
      return const Center(
        child: SizedBox(
          height: 28,
          child: Center(child: AppSpinner(size: 22, color: AppColors.accent)),
        ),
      );
    }
    return Row(
      children: [
        const Expanded(child: _Rule()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
          child: AppText(
            "You've reached the end",
            style: AppTextStyles.caption,
            color: AppColors.textTertiary,
          ),
        ),
        const Expanded(child: _Rule()),
      ],
    );
  }
}

class _Rule extends StatelessWidget {
  const _Rule();

  @override
  Widget build(BuildContext context) =>
      const SizedBox(height: 1, child: ColoredBox(color: AppColors.border));
}

class RefreshNotice extends StatelessWidget {
  const RefreshNotice({super.key, required this.failure});

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.l,
        AppSpacing.s,
        AppSpacing.l,
        0,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.m,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.danger.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppRadii.m),
          border: Border.all(color: AppColors.danger.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const AppIcon(
              LucideIcons.circleAlert,
              size: 16,
              color: AppColors.danger,
            ),
            const SizedBox(width: AppSpacing.s),
            Expanded(
              child: AppText(
                failure is OfflineFailure
                    ? "You're offline. Showing earlier results."
                    : "Couldn't refresh. Showing earlier results.",
                style: AppTextStyles.caption,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
