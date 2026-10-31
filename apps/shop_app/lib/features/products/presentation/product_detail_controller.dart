import 'package:flutter/foundation.dart';

import '../domain/product.dart';
import '../domain/product_repository.dart';

/// Starts from the product the list already has, so the Hero lands on real
/// content, then quietly swaps in the freshest copy.
class ProductDetailController extends ValueNotifier<Product> {
  ProductDetailController(this._repository, super.seed);

  final ProductRepository _repository;
  bool _disposed = false;

  Future<void> refresh() async {
    try {
      final fresh = await _repository.fetchById(value.id);
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
