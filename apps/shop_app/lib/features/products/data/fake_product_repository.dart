import 'dart:math';

import '../../../core/connectivity_status.dart';
import '../../../core/failure.dart';
import '../../../dev/fake_scenario.dart';
import '../domain/product.dart';
import '../domain/product_page.dart';
import '../domain/product_repository.dart';
import 'fake_product_catalog.dart';

class FakeProductRepository implements ProductRepository {
  FakeProductRepository({required this.scenario, required this.connectivity});

  final ScenarioController scenario;
  final ConnectivityStatus connectivity;
  final _random = Random();
  Future<FakeProductCatalog>? _catalog;

  @override
  Future<ProductPage> fetchPage({required int skip, required int limit}) async {
    await _simulateRequest();
    final mode = scenario.value;
    if (mode == FakeScenario.error) throw const ServerFailure();
    if (mode == FakeScenario.failLoadMore && skip > 0) {
      throw const ServerFailure();
    }
    if (mode == FakeScenario.empty) {
      return ProductPage(items: const [], total: 0, skip: skip, limit: limit);
    }
    final all = (await _loadCatalog()).products;
    return ProductPage(
      items: all.skip(skip).take(limit).toList(growable: false),
      total: all.length,
      skip: skip,
      limit: limit,
    );
  }

  @override
  Future<Product> fetchById(int id) async {
    await _simulateRequest();
    if (scenario.value == FakeScenario.error) throw const ServerFailure();
    final all = (await _loadCatalog()).products;
    return all.firstWhere(
      (p) => p.id == id,
      orElse: () => throw const ServerFailure(),
    );
  }

  Future<FakeProductCatalog> _loadCatalog() =>
      _catalog ??= FakeProductCatalog.load();

  Future<void> _simulateRequest() async {
    final slow = scenario.value == FakeScenario.slowLoading;
    await Future<void>.delayed(
      Duration(milliseconds: slow ? 4000 : 450 + _random.nextInt(350)),
    );
    if (!connectivity.online.value) throw const OfflineFailure();
  }
}
