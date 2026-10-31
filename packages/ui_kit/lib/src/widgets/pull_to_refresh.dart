import 'dart:math' as math;

import 'package:flutter/semantics.dart' show CustomSemanticsAction;

import 'package:flutter/widgets.dart';

import '../tokens/app_colors.dart';
import 'app_spinner.dart';

/// A scroll view with a pull-down refresh indicator, built on overscroll
/// notifications. Always scrollable so short, empty and error content can be
/// pulled too.
class PullToRefresh extends StatefulWidget {
  const PullToRefresh({
    super.key,
    required this.onRefresh,
    required this.slivers,
    this.controller,
    this.padding = EdgeInsets.zero,
  });

  final Future<void> Function() onRefresh;
  final List<Widget> slivers;
  final ScrollController? controller;
  final EdgeInsets padding;

  static const _trigger = 76.0;
  static const _hold = 64.0;

  @override
  State<PullToRefresh> createState() => _PullToRefreshState();
}

class _PullToRefreshState extends State<PullToRefresh>
    with SingleTickerProviderStateMixin {
  final _pull = ValueNotifier<double>(0);
  late final AnimationController _holdController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
  );
  bool _refreshing = false;
  bool _armed = false;

  @override
  void dispose() {
    _pull.dispose();
    _holdController.dispose();
    super.dispose();
  }

  bool _onScroll(ScrollNotification n) {
    if (n.depth != 0 || n.metrics.axis != Axis.vertical) return false;
    final pulled = math.max(0.0, -n.metrics.pixels);
    _pull.value = pulled;

    final dragging = n is ScrollUpdateNotification
        ? n.dragDetails != null
        : n is OverscrollNotification && n.dragDetails != null;
    if (dragging) {
      _armed = pulled >= PullToRefresh._trigger;
    } else if (_armed && !_refreshing) {
      _armed = false;
      _start();
    }
    if (n is ScrollEndNotification) _armed = false;
    return false;
  }

  Future<void> _start() async {
    _refreshing = true;
    _holdController.forward();
    try {
      await widget.onRefresh();
    } finally {
      if (mounted) {
        _refreshing = false;
        await _holdController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      customSemanticsActions: {
        const CustomSemanticsAction(label: 'Refresh'): () {
          if (!_refreshing) _start();
        },
      },
      child: _content(),
    );
  }

  Widget _content() {
    return Stack(
      children: [
        Positioned.fill(
          child: ListenableBuilder(
            listenable: Listenable.merge([_pull, _holdController]),
            builder: (context, _) {
              final gap =
                  _pull.value + _holdController.value * PullToRefresh._hold;
              return Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: gap,
                  child: _Indicator(
                    gap: gap,
                    progress: _pull.value / PullToRefresh._trigger,
                    refreshing: _refreshing,
                  ),
                ),
              );
            },
          ),
        ),
        NotificationListener<ScrollNotification>(
          onNotification: _onScroll,
          child: CustomScrollView(
            controller: widget.controller,
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: AnimatedBuilder(
                  animation: _holdController,
                  builder: (_, _) => SizedBox(
                    height: _holdController.value * PullToRefresh._hold,
                  ),
                ),
              ),
              SliverPadding(
                padding: widget.padding,
                sliver: SliverMainAxisGroup(slivers: widget.slivers),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    required this.gap,
    required this.progress,
    required this.refreshing,
  });

  final double gap;
  final double progress;
  final bool refreshing;

  @override
  Widget build(BuildContext context) {
    final visible = math.min(1.0, gap / 36);
    return ClipRect(
      child: Center(
        child: Opacity(
          opacity: visible,
          child: Transform.scale(
            scale: 0.6 + 0.4 * visible,
            child: refreshing
                ? const AppSpinner(size: 24, color: AppColors.primaryTop)
                : CustomPaint(
                    size: const Size.square(24),
                    painter: _PullPainter(progress: progress.clamp(0.0, 1.0)),
                  ),
          ),
        ),
      ),
    );
  }
}

class _PullPainter extends CustomPainter {
  const _PullPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 2.4;
    final rect = (Offset.zero & size).deflate(stroke / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      rect,
      0,
      math.pi * 2,
      false,
      paint..color = AppColors.primaryTop.withValues(alpha: 0.18),
    );
    canvas.drawArc(
      rect,
      -math.pi / 2,
      math.pi * 2 * progress * 0.9,
      false,
      paint..color = AppColors.primaryTop,
    );
  }

  @override
  bool shouldRepaint(_PullPainter old) => old.progress != progress;
}
