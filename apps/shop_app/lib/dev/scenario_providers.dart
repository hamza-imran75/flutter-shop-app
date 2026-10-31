import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/connectivity_status.dart';
import 'fake_scenario.dart';

const _initialScenario = String.fromEnvironment(
  'FAKE_SCENARIO',
  defaultValue: 'normal',
);

final scenarioControllerProvider = Provider<ScenarioController>((ref) {
  final controller = ScenarioController(FakeScenario.parse(_initialScenario));
  ref.onDispose(controller.dispose);
  return controller;
});

ConnectivityStatus fakeConnectivity(Ref ref) {
  final status = FakeConnectivityStatus(ref.watch(scenarioControllerProvider));
  ref.onDispose(status.dispose);
  return status;
}
