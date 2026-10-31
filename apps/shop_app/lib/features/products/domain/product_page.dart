import 'product.dart';

class ProductPage {
  const ProductPage({
    required this.items,
    required this.total,
    required this.skip,
    required this.limit,
  });

  final List<Product> items;
  final int total;
  final int skip;
  final int limit;

  bool get hasMore => skip + items.length < total;
}
