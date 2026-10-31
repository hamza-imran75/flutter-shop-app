import 'package:dummyjson_api/dummyjson_api.dart' show AuthApi;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:network/network.dart';

import '../core/core_providers.dart';
import '../core/service_connectivity_status.dart';
import '../features/auth/auth_providers.dart';
import '../features/auth/data/api_auth_repository.dart';
import '../features/auth/data/api_token_refresher.dart';
import '../features/cart/cart_providers.dart';
import '../features/cart/data/in_memory_cart_repository.dart';
import '../features/products/data/api_product_repository.dart';
import '../features/products/products_providers.dart';
import 'app_config.dart';

final _tokenStoreProvider = Provider<TokenStore>((_) => SecureTokenStore());

final _sessionEventsProvider = Provider<SessionEvents>((ref) {
  final events = SessionEvents();
  ref.onDispose(events.dispose);
  return events;
});

final _connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityService.http(baseUrl: AppConfig.apiBaseUrl);
  ref.onDispose(service.dispose);
  return service;
});

final _authApiProvider = Provider<AuthApi>((ref) {
  final dio = createDio(
    NetworkConfig(
      baseUrl: AppConfig.apiBaseUrl,
      tokens: ref.watch(_tokenStoreProvider),
      connectivity: ref.watch(_connectivityServiceProvider),
      sessionEvents: ref.watch(_sessionEventsProvider),
      refresh: refreshTokens,
      log: kDebugMode ? (message) => debugPrint('[net] $message') : null,
    ),
  );
  return AuthApi(dio);
});

/// The only place that knows which implementations back the app.
List<Override> appOverrides() => [
  connectivityStatusProvider.overrideWith(
    (ref) => ServiceConnectivityStatus(ref.watch(_connectivityServiceProvider)),
  ),
  authRepositoryProvider.overrideWith(
    (ref) => ApiAuthRepository(
      api: ref.watch(_authApiProvider),
      tokens: ref.watch(_tokenStoreProvider),
      events: ref.watch(_sessionEventsProvider),
      accessTokenMins: AppConfig.accessTokenMins,
    ),
  ),
  productRepositoryProvider.overrideWith(
    (ref) => ApiProductRepository(ref.watch(_authApiProvider)),
  ),
  cartRepositoryProvider.overrideWith((ref) {
    final repository = InMemoryCartRepository();
    ref.onDispose(repository.dispose);
    return repository;
  }),
];
