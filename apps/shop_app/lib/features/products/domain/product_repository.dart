import 'product.dart';
import 'product_page.dart';

abstract interface class ProductRepository {
  Future<ProductPage> fetchPage({required int skip, required int limit});

  Future<Product> fetchById(int id);
}
