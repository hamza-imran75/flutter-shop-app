import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

/// Full-screen gallery. Pinch or double-tap to zoom, swipe to change image.
class ImageViewerScreen extends StatefulWidget {
  const ImageViewerScreen({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  final List<String> images;
  final int initialIndex;

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  late final _pages = PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;
  bool _zoomed = false;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    return ColoredBox(
      color: const Color(0xFF050609),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pages,
            physics: _zoomed
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) => _ZoomableImage(
              key: ValueKey(i),
              url: widget.images[i],
              onZoomChanged: (zoomed) {
                if (i == _index && zoomed != _zoomed) {
                  setState(() => _zoomed = zoomed);
                }
              },
            ),
          ),
          Positioned(
            top: padding.top + AppSpacing.m,
            left: AppSpacing.l,
            child: AppIconButton(
              icon: LucideIcons.x,
              semanticLabel: 'Close',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          if (widget.images.length > 1)
            Positioned(
              top: padding.top + AppSpacing.m,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Center(
                  child: SizedBox(
                    height: 40,
                    child: Center(
                      child: AppText(
                        '${_index + 1} / ${widget.images.length}',
                        style: AppTextStyles.caption,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ZoomableImage extends StatefulWidget {
  const _ZoomableImage({
    super.key,
    required this.url,
    required this.onZoomChanged,
  });

  final String url;
  final ValueChanged<bool> onZoomChanged;

  @override
  State<_ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<_ZoomableImage>
    with SingleTickerProviderStateMixin {
  static const _doubleTapScale = 2.5;

  final _transform = TransformationController();
  late final AnimationController _animation = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 240),
  );
  Animation<Matrix4>? _tween;
  Offset _tapPosition = Offset.zero;

  bool get _isZoomed => _transform.value.getMaxScaleOnAxis() > 1.01;

  @override
  void initState() {
    super.initState();
    _transform.addListener(_notify);
    _animation.addListener(() {
      if (_tween != null) _transform.value = _tween!.value;
    });
  }

  @override
  void dispose() {
    _transform.removeListener(_notify);
    _transform.dispose();
    _animation.dispose();
    super.dispose();
  }

  void _notify() {
    widget.onZoomChanged(_isZoomed);
    setState(() {});
  }

  void _toggleZoom() {
    final Matrix4 end;
    if (_isZoomed) {
      end = Matrix4.identity();
    } else {
      end = Matrix4.identity()
        ..translateByDouble(
          -_tapPosition.dx * (_doubleTapScale - 1),
          -_tapPosition.dy * (_doubleTapScale - 1),
          0,
          1,
        )
        ..scaleByDouble(_doubleTapScale, _doubleTapScale, 1, 1);
    }
    _tween = Matrix4Tween(
      begin: _transform.value,
      end: end,
    ).animate(CurvedAnimation(parent: _animation, curve: Curves.easeOutCubic));
    _animation.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onDoubleTapDown: (d) => _tapPosition = d.localPosition,
      onDoubleTap: _toggleZoom,
      child: InteractiveViewer(
        transformationController: _transform,
        maxScale: 5,
        panEnabled: _isZoomed,
        child: Center(
          child: Image.network(
            widget.url,
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
            loadingBuilder: (context, child, progress) => progress == null
                ? child
                : const Center(
                    child: AppSpinner(size: 28, color: AppColors.accent),
                  ),
            errorBuilder: (context, error, stack) => const Center(
              child: AppIcon(
                LucideIcons.imageOff,
                size: 32,
                color: AppColors.textTertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
