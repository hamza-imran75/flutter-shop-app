import 'package:flutter/widgets.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_spacing.dart';
import '../typography/app_text_styles.dart';
import '../widgets/app_spinner.dart';
import '../widgets/fade_slide_in.dart';
import 'offline_illustration.dart';

class OfflineView extends StatelessWidget {
  const OfflineView({
    super.key,
    this.title = "You're offline",
    this.message = 'Waiting for your connection to come back.',
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: '$title. $message',
      child: Center(
        child: FadeSlideIn(
          offset: 18,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl + 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const OfflineIllustration(),
                const SizedBox(height: AppSpacing.l),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title,
                ),
                const SizedBox(height: AppSpacing.s),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body
                      .copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: AppSpacing.xl),
                const AppSpinner(
                  size: 22,
                  color: AppColors.accent,
                  strokeWidth: 2.2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
