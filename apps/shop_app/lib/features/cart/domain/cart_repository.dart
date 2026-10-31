import 'package:flutter/foundation.dart';

import '../../products/domain/product.dart';
import 'cart.dart';

abstract interface class CartRepository {
  ValueListenable<Cart> get cart;

  void add(Product product);

  void setQuantity(int productId, int quantity);

  void remove(int productId);

  void clear();
}
