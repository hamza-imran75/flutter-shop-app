import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';

/// A listenable of `select(source.value)` that notifies only when the selected
/// value changes, so a widget watching it ignores unrelated source updates.
ValueListenable<R> deriveListenable<S, R>(
  Ref ref,
  ValueListenable<S> source,
  R Function(S) select,
) {
  final derived = ValueNotifier<R>(select(source.value));
  void sync() => derived.value = select(source.value);
  source.addListener(sync);
  ref.onDispose(() {
    source.removeListener(sync);
    derived.dispose();
  });
  return derived;
}
