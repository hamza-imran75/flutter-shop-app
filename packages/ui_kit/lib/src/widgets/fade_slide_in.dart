import 'package:flutter/widgets.dart';

import 'motion.dart';

/// Fades and lifts [child] in once, after [delay]. With [play] false the child
/// is shown immediately, so rebuilt list items don't replay the entrance.
class FadeSlideIn extends StatefulWidget {
  const FadeSlideIn({
    super.key,
    required this.child,
    this.play = true,
    this.delay = Duration.zero,
    this.offset = 14,
  });

  final Widget child;
  final bool play;
  final Duration delay;
  final double offset;

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
  );

  bool _started = false;

  late final Animation<double> _curve = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (!widget.play || context.reduceMotion) {
      _controller.value = 1;
      return;
    }
    Future<void>.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curve,
      child: widget.child,
      builder: (context, child) => Opacity(
        opacity: _curve.value,
        child: Transform.translate(
          offset: Offset(0, (1 - _curve.value) * widget.offset),
          child: child,
        ),
      ),
    );
  }
}
