import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

/// Fade plus a short horizontal drift. The Hero flight does the heavy lifting,
/// so the page itself stays quiet.
PageRoute<T> appRoute<T>(WidgetBuilder builder, {RouteSettings? settings}) {
  return PageRouteBuilder<T>(
    settings: settings,
    transitionDuration: const Duration(milliseconds: 420),
    reverseTransitionDuration: const Duration(milliseconds: 320),
    pageBuilder: (context, _, _) => builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      if (context.reduceMotion) return child;
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween(
            begin: const Offset(0.08, 0),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

/// Plain cross-fade for full-screen overlays such as the image viewer.
PageRoute<T> fadeRoute<T>(WidgetBuilder builder) {
  return PageRouteBuilder<T>(
    opaque: false,
    transitionDuration: const Duration(milliseconds: 260),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, _, _) => builder(context),
    transitionsBuilder: (context, animation, _, child) => context.reduceMotion
        ? child
        : FadeTransition(opacity: animation, child: child),
  );
}
