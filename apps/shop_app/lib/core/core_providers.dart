import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';

import 'connectivity_status.dart';

final connectivityStatusProvider = Provider<ConnectivityStatus>(
  (ref) =>
      throw UnimplementedError('connectivityStatusProvider must be overridden'),
);

/// Set only when a developer panel exists. Presentation code calls it without
/// knowing what it opens.
final devPanelLauncherProvider = Provider<void Function(BuildContext)?>(
  (ref) => null,
);
