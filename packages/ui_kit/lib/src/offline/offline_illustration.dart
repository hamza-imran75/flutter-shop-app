import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// An astronaut sitting on a small planet beside a dropped signal icon.
/// Drawn in a 240x240 design space and scaled to fit.
class OfflineIllustration extends StatelessWidget {
  const OfflineIllustration({super.key, this.size = 220});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: const CustomPaint(painter: _IllustrationPainter()),
    );
  }
}

class _IllustrationPainter extends CustomPainter {
  const _IllustrationPainter();

  static const _stars = <(double, double, double, double)>[
    (28, 40, 1.4, 0.9),
    (52, 22, 1.0, 0.6),
    (84, 46, 1.2, 0.7),
    (160, 24, 1.6, 0.9),
    (206, 92, 1.2, 0.6),
    (34, 112, 1.0, 0.5),
    (18, 160, 1.4, 0.7),
    (214, 150, 1.0, 0.5),
    (188, 20, 1.0, 0.5),
    (66, 84, 0.9, 0.4),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 240, size.height / 240);
    _glow(canvas);
    _starfield(canvas);
    _moon(canvas);
    _signal(canvas);
    _planet(canvas);
    _astronaut(canvas);
  }

  void _glow(Canvas canvas) {
    final rect = Rect.fromCircle(center: const Offset(120, 112), radius: 118);
    canvas.drawCircle(
      rect.center,
      rect.width / 2,
      Paint()
        ..shader = const RadialGradient(
          colors: [Color(0x446B5BFF), Color(0x00231B66)],
        ).createShader(rect),
    );
  }

  void _starfield(Canvas canvas) {
    for (final (x, y, r, a) in _stars) {
      canvas.drawCircle(
        Offset(x, y),
        r,
        Paint()..color = const Color(0xFFD9D6FF).withValues(alpha: a),
      );
    }
    final sparkle = Paint()
      ..color = const Color(0xFFEDEBFF)
      ..strokeWidth = 1.3
      ..strokeCap = StrokeCap.round;
    for (final c in const [Offset(46, 62), Offset(198, 54)]) {
      canvas.drawLine(c.translate(-4, 0), c.translate(4, 0), sparkle);
      canvas.drawLine(c.translate(0, -4), c.translate(0, 4), sparkle);
    }
  }

  void _moon(Canvas canvas) {
    const c = Offset(194, 118);
    canvas.drawCircle(
      c,
      11,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF8E86F5), Color(0xFF453C9E)],
        ).createShader(Rect.fromCircle(center: c, radius: 11)),
    );
    canvas.drawCircle(
      c.translate(-3, 2),
      2.6,
      Paint()..color = const Color(0x33231B66),
    );
  }

  void _signal(Canvas canvas) {
    const origin = Offset(166, 66);
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF9D96F8);
    for (final r in const [9.0, 17.0, 25.0]) {
      canvas.drawArc(
        Rect.fromCircle(center: origin, radius: r),
        -math.pi * 0.82,
        math.pi * 0.64,
        false,
        arc..color = const Color(0xFF9D96F8).withValues(alpha: 1 - r / 48),
      );
    }
    canvas.drawCircle(origin, 3, Paint()..color = const Color(0xFF9D96F8));
    final slash = Paint()
      ..strokeWidth = 3.6
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFFF7A8A);
    canvas.drawLine(origin.translate(-17, -26), origin.translate(17, 8), slash);
  }

  void _planet(Canvas canvas) {
    const center = Offset(120, 318);
    const radius = 170.0;
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF8577FF), Color(0xFF3E2F9C), Color(0xFF241A66)],
          stops: [0, 0.35, 1],
        ).createShader(rect),
    );
    canvas.drawArc(
      rect.deflate(1),
      -math.pi * 0.68,
      math.pi * 0.36,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..color = const Color(0x66FFFFFF),
    );
    final crater = Paint()..color = const Color(0x33160F4F);
    final rim = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0x22FFFFFF);
    for (final r in const [
      Rect.fromLTWH(52, 172, 36, 11),
      Rect.fromLTWH(156, 184, 30, 9),
      Rect.fromLTWH(104, 198, 26, 8),
    ]) {
      canvas.drawOval(r, crater);
      canvas.drawOval(r.translate(0, 1), rim);
    }
  }

  void _astronaut(Canvas canvas) {
    canvas.save();
    canvas.translate(120, 154);
    canvas.rotate(-0.1);
    canvas.translate(-120, -154);

    canvas.drawOval(
      Rect.fromCenter(center: const Offset(120, 156), width: 70, height: 10),
      Paint()..color = const Color(0x44160F4F),
    );

    final suit = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFFFFF), Color(0xFFD4D1F5)],
      ).createShader(const Rect.fromLTWH(90, 60, 60, 100));
    final limb = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 14
      ..color = const Color(0xFFE6E4FA);
    final dark = Paint()..color = const Color(0xFF4B3CC4);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: const Offset(120, 116), width: 62, height: 44),
        const Radius.circular(14),
      ),
      Paint()..color = const Color(0xFF8F8AE0),
    );

    canvas.drawLine(const Offset(111, 134), const Offset(103, 154), limb);
    canvas.drawLine(const Offset(129, 134), const Offset(139, 154), limb);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(94, 150, 18, 9),
        const Radius.circular(4.5),
      ),
      dark,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(130, 150, 18, 9),
        const Radius.circular(4.5),
      ),
      dark,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: const Offset(120, 116), width: 46, height: 46),
        const Radius.circular(16),
      ),
      suit,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: const Offset(120, 118), width: 22, height: 13),
        const Radius.circular(4),
      ),
      dark,
    );
    canvas.drawCircle(
      const Offset(115, 118),
      2,
      Paint()..color = const Color(0xFF7CF0B4),
    );
    canvas.drawCircle(
      const Offset(125, 118),
      2,
      Paint()..color = const Color(0xFFFF7A8A),
    );

    canvas.drawLine(const Offset(99, 108), const Offset(90, 128), limb);
    canvas.drawCircle(const Offset(89, 130), 7, dark);
    final raised = Path()
      ..moveTo(141, 108)
      ..quadraticBezierTo(158, 104, 156, 88);
    canvas.drawPath(raised, limb);
    canvas.drawCircle(const Offset(156, 86), 7, dark);

    const helmet = Offset(120, 82);
    canvas.drawCircle(
      helmet,
      30,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFFFF), Color(0xFFCFCBF4)],
        ).createShader(Rect.fromCircle(center: helmet, radius: 30)),
    );
    final visor = Rect.fromCenter(
      center: helmet.translate(2, 1),
      width: 44,
      height: 36,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(visor, const Radius.circular(17)),
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3A2F96), Color(0xFF130F3F)],
        ).createShader(visor),
    );
    canvas.drawOval(
      Rect.fromCenter(center: helmet.translate(-6, -7), width: 14, height: 8),
      Paint()..color = const Color(0x55FFFFFF),
    );
    canvas.drawCircle(
      helmet.translate(9, 6),
      1.6,
      Paint()..color = const Color(0x44FFFFFF),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_IllustrationPainter old) => false;
}
