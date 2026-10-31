import 'package:flutter/widgets.dart';

import '../widgets/fade_switcher.dart';
import 'offline_view.dart';

/// Swaps [child] for the offline view while a request is in flight and there
/// is no connectivity. Callers supply the two flags so the gate works with any
/// async screen.
class OfflineGate extends StatelessWidget {
  const OfflineGate({
    super.key,
    required this.loading,
    required this.online,
    required this.child,
  });

  final bool loading;
  final bool online;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final offline = loading && !online;
    return FadeSwitcher(
      child: offline
          ? const OfflineView(key: ValueKey('offline'))
          : KeyedSubtree(key: const ValueKey('content'), child: child),
    );
  }
}
