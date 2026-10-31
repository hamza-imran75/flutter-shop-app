import 'dart:async';

/// Tells the app that the refresh token was rejected and tokens were cleared.
class SessionEvents {
  final _expired = StreamController<void>.broadcast();

  Stream<void> get expired => _expired.stream;

  void emitExpired() => _expired.add(null);

  Future<void> dispose() => _expired.close();
}
