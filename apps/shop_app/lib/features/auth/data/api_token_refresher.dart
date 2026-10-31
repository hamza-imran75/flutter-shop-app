import 'package:dummyjson_api/dummyjson_api.dart';
import 'package:network/network.dart';

import '../../../app/app_config.dart';

/// The refresh call the network package runs on a 401. The server may rotate
/// the refresh token, so the new one is kept when present.
Future<AuthTokens> refreshTokens(Dio refreshDio, String refreshToken) async {
  final response = await AuthApi(refreshDio).authRefresh(
    authRefreshRequest: AuthRefreshRequest(
      refreshToken: refreshToken,
      expiresInMins: AppConfig.accessTokenMins,
    ),
  );
  final tokens = response.data;
  final access = tokens?.accessToken;
  if (access == null) throw const FormatException('Refresh without a token');
  return AuthTokens(
    accessToken: access,
    refreshToken: tokens?.refreshToken ?? refreshToken,
  );
}
