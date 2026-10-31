import 'package:context_watch/context_watch.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import '../core/provider_scope.dart';
import 'fake_scenario.dart';
import 'scenario_providers.dart';

/// Opens the developer panel as a bottom sheet.
void showScenarioPanel(BuildContext context) {
  Navigator.of(context).push(
    PageRouteBuilder<void>(
      opaque: false,
      barrierDismissible: true,
      barrierColor: const Color(0x99000000),
      barrierLabel: 'Close developer panel',
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (context, _, _) => const _PanelSheet(),
      transitionsBuilder: (context, animation, _, child) => SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          ),
        ),
        child: child,
      ),
    ),
  );
}

class _PanelSheet extends StatelessWidget {
  const _PanelSheet();

  @override
  Widget build(BuildContext context) {
    final scenario = context.read(scenarioControllerProvider);
    final current = scenario.watch(context);
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Align(
      alignment: Alignment.bottomCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.85,
        ),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadii.xl),
            ),
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.l,
              AppSpacing.m,
              AppSpacing.l,
              AppSpacing.l + bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: _Grabber()),
                const SizedBox(height: AppSpacing.l),
                AppText('Developer panel', style: AppTextStyles.heading),
                const SizedBox(height: 2),
                AppText(
                  'Pick how the fake backend behaves.',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.m),
                for (final option in FakeScenario.values)
                  _Option(
                    scenario: option,
                    selected: option == current,
                    onTap: () => scenario.value = option,
                  ),
                const SizedBox(height: AppSpacing.m),
                AppButton(
                  label: 'Connectivity restored',
                  icon: LucideIcons.wifi,
                  onPressed: current == FakeScenario.offline
                      ? scenario.restoreConnectivity
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Grabber extends StatelessWidget {
  const _Grabber();

  @override
  Widget build(BuildContext context) => const SizedBox(
    width: 36,
    height: 4,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    ),
  );
}

class _Option extends StatelessWidget {
  const _Option({
    required this.scenario,
    required this.selected,
    required this.onTap,
  });

  final FakeScenario scenario;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: '${scenario.label}. ${scenario.description}',
      excludeSemantics: true,
      child: Pressable(
        onTap: onTap,
        pressedScale: 0.99,
        builder: (context, _) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.m,
              vertical: AppSpacing.m,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.primaryTop.withValues(alpha: 0.12)
                  : AppColors.surfaceRaised,
              borderRadius: BorderRadius.circular(AppRadii.m),
              border: Border.all(
                color: selected ? AppColors.primaryTop : AppColors.border,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(scenario.label, style: AppTextStyles.bodyStrong),
                      AppText(
                        scenario.description,
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
                if (selected)
                  const AppIcon(
                    LucideIcons.circleCheck,
                    size: 20,
                    color: AppColors.accent,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
