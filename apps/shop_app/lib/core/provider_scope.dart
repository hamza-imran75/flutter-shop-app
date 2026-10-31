import 'package:flutter/widgets.dart';
import 'package:riverpod/misc.dart' show Override, ProviderListenable;
import 'package:riverpod/riverpod.dart';

/// Minimal bridge between the pure-Dart `riverpod` package and the widget
/// tree. `flutter_riverpod` is avoided because it imports Material.
class ProviderScope extends StatefulWidget {
  const ProviderScope({super.key, this.overrides = const [], required this.child});

  final List<Override> overrides;
  final Widget child;

  static ProviderContainer containerOf(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<_ScopeData>();
    assert(scope != null, 'No ProviderScope found above this context.');
    return scope!.container;
  }

  @override
  State<ProviderScope> createState() => _ProviderScopeState();
}

class _ProviderScopeState extends State<ProviderScope> {
  late final ProviderContainer _container =
      ProviderContainer(overrides: widget.overrides);

  @override
  void dispose() {
    _container.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _ScopeData(container: _container, child: widget.child);
}

class _ScopeData extends InheritedWidget {
  const _ScopeData({required this.container, required super.child});

  final ProviderContainer container;

  @override
  bool updateShouldNotify(_ScopeData old) => container != old.container;
}

extension ReadProvider on BuildContext {
  T read<T>(ProviderListenable<T> provider) =>
      ProviderScope.containerOf(this).read(provider);
}

/// Holds [provider] alive while this widget is mounted, so an auto-dispose
/// provider (for example a screen controller) lives and dies with its screen.
/// The resolved value is handed to [builder] and is not observed for changes.
class ProviderBuilder<T> extends StatefulWidget {
  const ProviderBuilder({super.key, required this.provider, required this.builder});

  final ProviderListenable<T> provider;
  final Widget Function(BuildContext context, T value) builder;

  @override
  State<ProviderBuilder<T>> createState() => _ProviderBuilderState<T>();
}

class _ProviderBuilderState<T> extends State<ProviderBuilder<T>> {
  ProviderSubscription<T>? _subscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _subscription ??= ProviderScope.containerOf(context)
        .listen<T>(widget.provider, (_, _) {});
  }

  @override
  void dispose() {
    _subscription?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, _subscription!.read());
}
