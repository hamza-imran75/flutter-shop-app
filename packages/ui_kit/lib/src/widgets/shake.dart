import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Shakes [child] horizontally each time [trigger] changes to a new non-null
/// object.
class Shake extends StatefulWidget {
  const Shake({super.key, required this.trigger, required this.child});

  final Object? trigger;
  final Widget child;

  @override
  State<Shake> createState() => _ShakeState();
}

class _ShakeState extends State<Shake> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
  );

  @override
  void didUpdateWidget(Shake old) {
    super.didUpdateWidget(old);
    if (widget.trigger != null && !identical(widget.trigger, old.trigger)) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final t = _controller.value;
        final dx = math.sin(t * math.pi * 5) * 8 * (1 - t);
        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
    );
  }
}
