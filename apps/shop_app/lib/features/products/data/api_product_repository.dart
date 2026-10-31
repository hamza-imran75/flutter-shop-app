import 'package:dummyjson_api/dummyjson_api.dart' as dto_api;

import '../../../core/failure.dart';
import '../../../core/failure_mapping.dart';
import '../domain/product.dart';
import '../domain/product_page.dart';
import '../domain/product_repository.dart';
import 'product_mappers.dart';

/// Reads the auth-protected product routes. The public ones never answer 401,
/// which would leave the refresh flow unreachable.
class ApiProductRepository implements ProductRepository {
  ApiProductRepository(this._api);

  final dto_api.AuthApi _api;

  @override
  Future<ProductPage> fetchPage({required int skip, required int limit}) =>
      _guard(() async {
        final response = await _api.authGetProducts(limit: limit, skip: skip);
        final body = response.data;
        if (body == null) throw const UnknownFailure();
        return pageFromDto(body);
      });

  @override
  Future<Product> fetchById(int id) => _guard(() async {
    final response = await _api.authGetProductById(id: id);
    final body = response.data;
    if (body == null) throw const UnknownFailure();
    return productFromDto(body);
  });

  Future<T> _guard<T>(Future<T> Function() call) async {
    try {
      return await call();
    } catch (e) {
      throw failureFromError(e);
    }
  }
}
