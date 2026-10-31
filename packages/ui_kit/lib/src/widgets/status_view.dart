import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_spacing.dart';
import '../typography/app_text_styles.dart';
import 'app_button.dart';
import 'app_icon.dart';

class StatusView extends StatelessWidget {
  const StatusView({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.tint = AppColors.accent,
    this.actionLabel,
    this.actionIcon,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final Color tint;
  final String? actionLabel;
  final IconData? actionIcon;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl + 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ExcludeSemantics(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: tint.withValues(alpha: 0.12),
                  border: Border.all(color: tint.withValues(alpha: 0.3)),
                ),
                child: Center(child: AppIcon(icon, size: 26, color: tint)),
              ),
            ),
            const SizedBox(height: AppSpacing.l),
            Semantics(
              container: true,
              liveRegion: true,
              label: '$title. $message',
              excludeSemantics: true,
              child: Column(
                children: [
                  Text(
                    title,
                    style: AppTextStyles.heading,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.s - 2),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (actionLabel != null) ...[
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                label: actionLabel!,
                icon: actionIcon,
                expand: false,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => StatusView(
    icon: icon,
    title: title,
    message: message,
    actionLabel: actionLabel,
    onAction: onAction,
  );
}

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.title,
    required this.message,
    required this.onRetry,
    this.retryLabel = 'Try again',
    this.icon,
  });

  final String title;
  final String message;
  final VoidCallback onRetry;
  final String retryLabel;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => StatusView(
    icon: icon ?? LucideIcons.triangleAlert,
    title: title,
    message: message,
    tint: AppColors.danger,
    actionLabel: retryLabel,
    actionIcon: LucideIcons.rotateCw,
    onAction: onRetry,
  );
}
