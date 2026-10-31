import 'package:flutter/foundation.dart';

import '../core/connectivity_status.dart';

enum FakeScenario {
  normal('Normal', 'Everything works.'),
  slowLoading('Slow loading', 'Requests take about four seconds.'),
  error('Server error', 'Every product request fails.'),
  empty('Empty catalog', 'The server returns no products.'),
  offline('Offline', 'No connectivity. Requests wait for it to return.'),
  failLoadMore('Fail load more', 'The first page loads, later pages fail.');

  const FakeScenario(this.label, this.description);

  final String label;
  final String description;

  static FakeScenario parse(String name) => FakeScenario.values.firstWhere(
    (s) => s.name == name,
    orElse: () => FakeScenario.normal,
  );
}

class ScenarioController extends ValueNotifier<FakeScenario> {
  ScenarioController(super.initial);

  void restoreConnectivity() {
    if (value == FakeScenario.offline) value = FakeScenario.normal;
  }
}

class FakeConnectivityStatus implements ConnectivityStatus {
  FakeConnectivityStatus(this._scenario)
    : _online = ValueNotifier(_scenario.value != FakeScenario.offline) {
    _scenario.addListener(_sync);
  }

  final ScenarioController _scenario;
  final ValueNotifier<bool> _online;

  void _sync() => _online.value = _scenario.value != FakeScenario.offline;

  @override
  ValueListenable<bool> get online => _online;

  void dispose() {
    _scenario.removeListener(_sync);
    _online.dispose();
  }
}
