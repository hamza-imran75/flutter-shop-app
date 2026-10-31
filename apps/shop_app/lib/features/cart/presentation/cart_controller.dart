import 'package:flutter/foundation.dart';

import '../domain/cart.dart';
import '../domain/cart_repository.dart';
import 'cart_state.dart';

class CartController extends ValueNotifier<CartState> {
  CartController(this._repository) : super(_stateFor(_repository.cart.value)) {
    _repository.cart.addListener(_sync);
  }

  final CartRepository _repository;
  bool _disposed = false;

  static CartState _stateFor(Cart cart) =>
      cart.isEmpty ? const CartEmpty() : CartReview(cart);

  void _sync() {
    final current = value;
    final locked =
        current is CartPlaced || (current is CartReview && current.checkingOut);
    if (!locked) value = _stateFor(_repository.cart.value);
  }

  void setQuantity(int productId, int quantity) =>
      _repository.setQuantity(productId, quantity);

  void remove(int productId) => _repository.remove(productId);

  /// There is no order API yet, so checkout is a short wait that empties the
  /// cart and reports what was bought.
  Future<void> checkout() async {
    final current = value;
    if (current is! CartReview || current.checkingOut) return;
    value = CartReview(current.cart, checkingOut: true);
    await Future<void>.delayed(const Duration(milliseconds: 1400));
    if (_disposed) return;
    final placed = CartPlaced(
      itemCount: current.cart.itemCount,
      total: current.cart.total,
    );
    value = placed;
    _repository.clear();
  }

  @override
  void dispose() {
    _disposed = true;
    _repository.cart.removeListener(_sync);
    super.dispose();
  }
}
