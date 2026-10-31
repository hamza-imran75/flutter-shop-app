import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/derived_listenable.dart';
import 'domain/cart_repository.dart';
import 'presentation/cart_controller.dart';

final cartRepositoryProvider = Provider<CartRepository>(
  (ref) =>
      throw UnimplementedError('cartRepositoryProvider must be overridden'),
);

final cartItemCountProvider = Provider<ValueListenable<int>>(
  (ref) => deriveListenable(
    ref,
    ref.watch(cartRepositoryProvider).cart,
    (cart) => cart.itemCount,
  ),
);

/// One listenable per product, so only the card or bar showing that product
/// rebuilds when its quantity changes.
final cartQuantityProvider = Provider.family<ValueListenable<int>, int>(
  (ref, productId) => deriveListenable(
    ref,
    ref.watch(cartRepositoryProvider).cart,
    (cart) => cart.quantityOf(productId),
  ),
);

final cartControllerProvider = Provider.autoDispose<CartController>((ref) {
  final controller = CartController(ref.watch(cartRepositoryProvider));
  ref.onDispose(controller.dispose);
  return controller;
});
