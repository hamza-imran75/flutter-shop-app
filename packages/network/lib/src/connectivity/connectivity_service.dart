import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

typedef ReachabilityProbe = Future<bool> Function();

/// Online means the network interface is up and the probe reaches the server.
/// The interface alone lies behind captive portals and dead Wi-Fi.
///
/// It starts optimistic, so the first request is never blocked, and it polls
/// while offline because an interface that stays up sends no event when the
/// internet returns.
class ConnectivityService {
  ConnectivityService({
    required this._probe,
    Connectivity? connectivity,
    this.debounce = const Duration(milliseconds: 400),
    this.offlinePollInterval = const Duration(seconds: 4),
    this._forceOffline,
  }) : _connectivity = connectivity ?? Connectivity() {
    _subscription = _connectivity.onConnectivityChanged.listen(
      (_) => _scheduleCheck(),
    );
    _forceOffline?.addListener(_publish);
    _scheduleCheck(immediately: true);
  }

  /// Probes with a HEAD request. Any HTTP answer, even an error status, proves
  /// the host is reachable.
  factory ConnectivityService.http({
    required String baseUrl,
    String path = '/',
    Duration timeout = const Duration(seconds: 3),
    ValueListenable<bool>? forceOffline,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeout,
        receiveTimeout: timeout,
        validateStatus: (_) => true,
      ),
    );
    return ConnectivityService(
      forceOffline: forceOffline,
      probe: () async {
        try {
          await dio.head<void>(path);
          return true;
        } on DioException {
          return false;
        }
      },
    );
  }

  final ReachabilityProbe _probe;
  final Connectivity _connectivity;
  final ValueListenable<bool>? _forceOffline;
  final Duration debounce;
  final Duration offlinePollInterval;

  final _online = ValueNotifier<bool>(true);
  late final StreamSubscription<List<ConnectivityResult>> _subscription;
  bool _reachable = true;
  Timer? _debounceTimer;
  Timer? _pollTimer;
  Future<void>? _checking;
  bool _disposed = false;

  ValueListenable<bool> get online => _online;

  bool get isOnline => _online.value;

  /// Checks reachability now. Callers use it after a request failed with a
  /// connection error while the status still said online.
  Future<void> recheck() =>
      _checking ??= _check().whenComplete(() => _checking = null);

  void _scheduleCheck({bool immediately = false}) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(immediately ? Duration.zero : debounce, recheck);
  }

  Future<void> _check() async {
    final interfaces = await _connectivity.checkConnectivity();
    final up = interfaces.any((r) => r != ConnectivityResult.none);
    final reachable = up && await _probe();
    if (_disposed) return;
    _reachable = reachable;
    _publish();
    _syncPolling();
  }

  void _publish() {
    _online.value = _reachable && !(_forceOffline?.value ?? false);
  }

  void _syncPolling() {
    if (_reachable) {
      _pollTimer?.cancel();
      _pollTimer = null;
    } else {
      _pollTimer ??= Timer.periodic(offlinePollInterval, (_) => recheck());
    }
  }

  void dispose() {
    _disposed = true;
    _debounceTimer?.cancel();
    _pollTimer?.cancel();
    _subscription.cancel();
    _forceOffline?.removeListener(_publish);
    _online.dispose();
  }
}
