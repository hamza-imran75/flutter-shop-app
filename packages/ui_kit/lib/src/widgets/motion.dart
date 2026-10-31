import 'package:flutter/widgets.dart';

/// Honors the system "reduce motion" setting.
extension ReducedMotion on BuildContext {
  bool get reduceMotion => MediaQuery.maybeDisableAnimationsOf(this) ?? false;

  Duration motion(Duration duration) => reduceMotion ? Duration.zero : duration;
}
