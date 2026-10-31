import 'package:flutter/widgets.dart';

/// Tap target that scales down while pressed. [builder] receives the 0..1
/// press progress so callers can tint their own content.
class Pressable extends StatefulWidget {
  const Pressable({
    super.key,
    required this.onTap,
    required this.builder,
    this.pressedScale = 0.97,
  });

  final VoidCallback? onTap;
  final Widget Function(BuildContext context, double pressed) builder;
  final double pressedScale;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 90),
    reverseDuration: const Duration(milliseconds: 180),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setPressed(bool pressed) {
    if (widget.onTap == null) return;
    pressed ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final curved = Curves.easeOut.transform(_controller.value);
          return Transform.scale(
            scale: 1 - (1 - widget.pressedScale) * curved,
            child: widget.builder(context, curved),
          );
        },
      ),
    );
  }
}
