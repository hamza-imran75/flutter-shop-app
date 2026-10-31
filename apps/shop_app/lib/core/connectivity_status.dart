import 'dart:async';

import 'package:flutter/foundation.dart';

import 'failure.dart';

abstract interface class ConnectivityStatus {
  ValueListenable<bool> get online;
}

extension ConnectivityWaiting on ConnectivityStatus {
  Future<void> untilOnline() {
    if (online.value) return Future.value();
    final completer = Completer<void>();
    void listener() {
      if (!online.value) return;
      online.removeListener(listener);
      completer.complete();
    }

    online.addListener(listener);
    return completer.future;
  }
}

/// Runs [operation], and when it fails offline waits for connectivity before
/// trying again. An offline failure while the status says online is surfaced
/// as is, since waiting would never end.
Future<T> retryWhenOnline<T>(
  ConnectivityStatus connectivity,
  Future<T> Function() operation,
) async {
  while (true) {
    try {
      return await operation();
    } on OfflineFailure {
      if (connectivity.online.value) rethrow;
      await connectivity.untilOnline();
    }
  }
}
