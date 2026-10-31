import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../tokens/app_colors.dart';

class AppSpinner extends StatefulWidget {
  const AppSpinner({
    super.key,
    this.size = 20,
    this.color = AppColors.textPrimary,
    this.strokeWidth = 2.4,
  });

  final double size;
  final Color color;
  final double strokeWidth;

  @override
  State<AppSpinner> createState() => _AppSpinnerState();
}

class _AppSpinnerState extends State<AppSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox.square(
        dimension: widget.size,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, _) => CustomPaint(
            painter: SpinnerPainter(
              turns: _controller.value,
              color: widget.color,
              strokeWidth: widget.strokeWidth,
            ),
          ),
        ),
      ),
    );
  }
}

class SpinnerPainter extends CustomPainter {
  const SpinnerPainter({
    required this.turns,
    required this.color,
    required this.strokeWidth,
  });

  final double turns;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(strokeWidth / 2);
    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color.withValues(alpha: 0.18);
    canvas.drawArc(rect, 0, math.pi * 2, false, track);

    const sweep = math.pi * 1.4;
    final start = turns * math.pi * 2;
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: sweep,
        colors: [color.withValues(alpha: 0), color],
        transform: GradientRotation(start),
      ).createShader(rect);
    canvas.drawArc(rect, start, sweep, false, arc);
  }

  @override
  bool shouldRepaint(SpinnerPainter old) =>
      old.turns != turns || old.color != color || old.strokeWidth != strokeWidth;
}
