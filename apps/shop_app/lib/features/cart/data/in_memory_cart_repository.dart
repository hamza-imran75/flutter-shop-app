import 'package:flutter/foundation.dart';

import '../../products/domain/product.dart';
import '../domain/cart.dart';
import '../domain/cart_repository.dart';

class InMemoryCartRepository implements CartRepository {
  final _cart = ValueNotifier<Cart>(Cart.empty);

  @override
  ValueListenable<Cart> get cart => _cart;

  @override
  void add(Product product) => _cart.value = _cart.value.add(product);

  @override
  void setQuantity(int productId, int quantity) =>
      _cart.value = _cart.value.setQuantity(productId, quantity);

  @override
  void remove(int productId) => _cart.value = _cart.value.remove(productId);

  @override
  void clear() => _cart.value = Cart.empty;

  void dispose() => _cart.dispose();
}
