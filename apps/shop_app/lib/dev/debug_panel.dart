import 'package:context_watch/context_watch.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_kit/ui_kit.dart';

import '../features/products/products_providers.dart';
import 'debug_providers.dart';

/// Opens the debug network panel as a bottom sheet.
void showDebugPanel(BuildContext context) {
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

class _PanelSheet extends ConsumerWidget {
  const _PanelSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controls = ref.watch(debugNetworkControlsProvider)!;
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Align(
      alignment: Alignment.bottomCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.88,
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
                  'Debug builds only. Break the network on purpose.',
                  style: AppTextStyles.caption,
                ),
                const _Section('Connectivity'),
                _Toggle(
                  label: 'Force offline',
                  description: 'Every request is refused as if offline.',
                  value: controls.forceOffline,
                ),
                const _Section('Server'),
                _Action(
                  label: 'Fail the next data request (500)',
                  description: 'Retry recovers on the second attempt.',
                  onTap: () => controls.failNextRequests(1),
                ),
                _Action(
                  label: 'Fail the next 4 data requests (500)',
                  description: 'Exhausts the retries, then shows an error.',
                  onTap: () => controls.failNextRequests(4),
                ),
                _Toggle(
                  label: 'Fail every request (500)',
                  description: 'Includes login. Stays on until switched off.',
                  value: controls.failAllWith500,
                ),
                const _Section('Session'),
                _Action(
                  label: 'Answer the next request with 401',
                  description: 'Triggers one refresh, then the replay.',
                  onTap: controls.unauthorizeNextRequest,
                ),
                _Action(
                  label: 'Invalidate the access token',
                  description: 'The server really rejects it with 401.',
                  onTap: controls.invalidateAccessToken,
                ),
                _Action(
                  label: 'Invalidate the refresh token',
                  description: 'The next refresh fails and ends the session.',
                  onTap: controls.invalidateRefreshToken,
                ),
                _Action(
                  label: 'Fire 3 requests at once',
                  description: 'With a 401 armed they share one refresh.',
                  onTap: () => _fireConcurrently(ref),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _fireConcurrently(WidgetRef ref) {
    final repository = ref.read(productRepositoryProvider);
    for (final id in const [1, 2, 3]) {
      repository
          .fetchById(id)
          .then(
            (p) => debugPrint('[panel] product $id ok'),
            onError: (Object e) => debugPrint('[panel] product $id failed: $e'),
          );
    }
  }
}

class _Section extends StatelessWidget {
  const _Section(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: AppSpacing.l, bottom: 4),
    child: AppText(title, style: AppTextStyles.bodyStrong),
  );
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

class _Toggle extends StatelessWidget {
  const _Toggle({
    required this.label,
    required this.description,
    required this.value,
  });

  final String label;
  final String description;
  final ValueNotifier<bool> value;

  @override
  Widget build(BuildContext context) {
    final on = value.watch(context);
    return _Tile(
      label: label,
      description: description,
      selected: on,
      semanticsLabel: '$label. ${on ? 'On' : 'Off'}',
      onTap: () => value.value = !on,
      trailing: AppText(
        on ? 'On' : 'Off',
        style: AppTextStyles.bodyStrong,
        color: on ? AppColors.accent : AppColors.textSecondary,
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({
    required this.label,
    required this.description,
    required this.onTap,
  });

  final String label;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) =>
      _Tile(label: label, description: description, onTap: onTap);
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.label,
    required this.description,
    required this.onTap,
    this.selected = false,
    this.trailing,
    this.semanticsLabel,
  });

  final String label;
  final String description;
  final VoidCallback onTap;
  final bool selected;
  final Widget? trailing;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: semanticsLabel ?? '$label. $description',
      excludeSemantics: true,
      child: Pressable(
        onTap: onTap,
        pressedScale: 0.99,
        builder: (context, _) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.all(AppSpacing.m),
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
                      AppText(label, style: AppTextStyles.bodyStrong),
                      AppText(description, style: AppTextStyles.caption),
                    ],
                  ),
                ),
                ?trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
