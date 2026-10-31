import 'package:riverpod/misc.dart' show Override;

import '../core/core_providers.dart';
import '../dev/scenario_providers.dart';
import '../features/auth/auth_providers.dart';
import '../features/cart/cart_providers.dart';
import '../features/cart/data/in_memory_cart_repository.dart';
import '../features/auth/data/fake_auth_repository.dart';
import '../features/products/data/fake_product_repository.dart';
import '../features/products/products_providers.dart';

/// The only place that knows which implementations back the app. Phase 2
/// replaces this list with the real network, storage and connectivity.
List<Override> appOverrides() => [
  connectivityStatusProvider.overrideWith(fakeConnectivity),
  authRepositoryProvider.overrideWith(
    (ref) =>
        FakeAuthRepository(connectivity: ref.watch(connectivityStatusProvider)),
  ),
  cartRepositoryProvider.overrideWith((ref) {
    final repository = InMemoryCartRepository();
    ref.onDispose(repository.dispose);
    return repository;
  }),
  productRepositoryProvider.overrideWith(
    (ref) => FakeProductRepository(
      scenario: ref.watch(scenarioControllerProvider),
      connectivity: ref.watch(connectivityStatusProvider),
    ),
  ),
];
