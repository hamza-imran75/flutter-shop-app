import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

/// Null unless a debug build overrides it.
final debugNetworkControlsProvider = Provider<DebugNetworkControls?>(
  (ref) => null,
);
