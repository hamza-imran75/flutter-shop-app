import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth_tokens.dart';
import 'token_store.dart';

/// Keychain on iOS, encrypted storage on Android. Reads are cached because the
/// auth interceptor asks for the token on every request.
class SecureTokenStore implements TokenStore {
  SecureTokenStore({
    this._storage = const FlutterSecureStorage(),
    this.namespace = 'auth',
  });

  final FlutterSecureStorage _storage;
  final String namespace;

  AuthTokens? _cached;
  bool _loaded = false;

  String get _accessKey => '$namespace.access_token';
  String get _refreshKey => '$namespace.refresh_token';

  @override
  Future<AuthTokens?> read() async {
    if (_loaded) return _cached;
    final access = await _storage.read(key: _accessKey);
    final refresh = await _storage.read(key: _refreshKey);
    _loaded = true;
    return _cached = access == null || refresh == null
        ? null
        : AuthTokens(accessToken: access, refreshToken: refresh);
  }

  @override
  Future<void> write(AuthTokens tokens) async {
    _cached = tokens;
    _loaded = true;
    await _storage.write(key: _accessKey, value: tokens.accessToken);
    await _storage.write(key: _refreshKey, value: tokens.refreshToken);
  }

  @override
  Future<void> clear() async {
    _cached = null;
    _loaded = true;
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
  }
}
