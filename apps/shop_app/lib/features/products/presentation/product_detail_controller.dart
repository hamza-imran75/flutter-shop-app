import 'package:flutter/foundation.dart';

import '../../../core/connectivity_status.dart';
import '../domain/product.dart';
import '../domain/product_repository.dart';

/// Starts from the product the list already has, so the Hero lands on real
/// content, then quietly swaps in the freshest copy. Offline, it waits for the
/// connection instead of giving up, so the upgrade still arrives.
class ProductDetailController extends ValueNotifier<Product> {
  ProductDetailController(this._repository, this._connectivity, super.seed);

  final ProductRepository _repository;
  final ConnectivityStatus _connectivity;
  bool _disposed = false;

  Future<void> refresh() async {
    try {
      final fresh = await retryWhenOnline(
        _connectivity,
        () => _repository.fetchById(value.id),
      );
      if (!_disposed) value = fresh;
    } catch (_) {
      // The list copy is already on screen, so a failed refresh needs no UI.
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
