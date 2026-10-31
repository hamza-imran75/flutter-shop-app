import 'package:dummyjson_api/dummyjson_api.dart';
import 'package:network/network.dart';

import '../../../core/failure.dart';
import '../../../core/failure_mapping.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_session.dart';
import 'auth_mappers.dart';

class ApiAuthRepository implements AuthRepository {
  ApiAuthRepository({
    required this._api,
    required this._tokens,
    required this._events,
    required this._accessTokenMins,
  });

  final AuthApi _api;
  final TokenStore _tokens;
  final SessionEvents _events;
  final int _accessTokenMins;

  @override
  Stream<void> get sessionExpired => _events.expired;

  @override
  Future<AuthSession> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _api.authLogin(
        authLoginRequest: AuthLoginRequest(
          username: username,
          password: password,
          expiresInMins: _accessTokenMins,
        ),
        extra: {NetworkExtras.skipAuth: true},
      );
      final body = response.data;
      final access = body?.accessToken;
      final refresh = body?.refreshToken;
      if (body == null || access == null || refresh == null) {
        throw const UnknownFailure();
      }
      final tokens = AuthTokens(accessToken: access, refreshToken: refresh);
      await _tokens.write(tokens);
      return AuthSession(
        user: userFromLogin(body),
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw const InvalidCredentialsFailure();
      }
      throw failureFromError(e);
    }
  }

  @override
  Future<void> logout() => _tokens.clear();

  @override
  Future<AuthSession?> restoreSession() async {
    if (await _tokens.read() == null) return null;
    try {
      final user = (await _api.authMe()).data;
      // The call may have refreshed the tokens, so read them afterwards.
      final tokens = await _tokens.read();
      if (user == null || tokens == null) return null;
      return AuthSession(
        user: userFromDto(user),
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );
    } on DioException catch (e) {
      final failure = failureFromError(e);
      if (failure is UnauthorizedFailure) {
        await _tokens.clear();
        return null;
      }
      throw failure;
    }
  }
}
