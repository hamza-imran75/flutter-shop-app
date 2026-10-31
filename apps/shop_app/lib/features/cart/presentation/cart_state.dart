import '../domain/cart.dart';

sealed class CartState {
  const CartState();
}

final class CartEmpty extends CartState {
  const CartEmpty();
}

final class CartReview extends CartState {
  const CartReview(this.cart, {this.checkingOut = false});

  final Cart cart;
  final bool checkingOut;
}

final class CartPlaced extends CartState {
  const CartPlaced({required this.itemCount, required this.total});

  final int itemCount;
  final double total;
}
