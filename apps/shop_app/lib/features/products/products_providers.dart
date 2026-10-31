import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/core_providers.dart';
import 'domain/product.dart';
import 'domain/product_repository.dart';
import 'presentation/product_detail_controller.dart';
import 'presentation/product_list_controller.dart';

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) =>
      throw UnimplementedError('productRepositoryProvider must be overridden'),
);

final productListControllerProvider =
    Provider.autoDispose<ProductListController>((ref) {
      final controller = ProductListController(
        repository: ref.watch(productRepositoryProvider),
        connectivity: ref.watch(connectivityStatusProvider),
      )..load();
      ref.onDispose(controller.dispose);
      return controller;
    });

final productDetailControllerProvider = Provider.autoDispose
    .family<ProductDetailController, Product>((ref, product) {
      final controller = ProductDetailController(
        ref.watch(productRepositoryProvider),
        ref.watch(connectivityStatusProvider),
        product,
      )..refresh();
      ref.onDispose(controller.dispose);
      return controller;
    });
