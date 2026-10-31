import 'package:dummyjson_api/dummyjson_api.dart' as dto_api;

import '../domain/product.dart';
import '../domain/product_page.dart';

Product productFromDto(dto_api.Product dto) {
  final id = dto.id;
  final title = dto.title;
  if (id == null || title == null) {
    throw const FormatException('Product without an id or title');
  }
  return Product(
    id: id,
    title: title,
    description: dto.description ?? '',
    price: (dto.price ?? 0).toDouble(),
    discountPercentage: (dto.discountPercentage ?? 0).toDouble(),
    rating: (dto.rating ?? 0).toDouble(),
    stock: dto.stock ?? 0,
    brand: dto.brand,
    category: dto.category ?? '',
    thumbnail: dto.thumbnail ?? '',
    images: dto.images ?? const [],
    tags: dto.tags ?? const [],
  );
}

ProductPage pageFromDto(dto_api.ProductList dto) {
  final items = (dto.products ?? const []).map(productFromDto).toList();
  return ProductPage(
    items: items,
    total: dto.total ?? items.length,
    skip: dto.skip ?? 0,
    limit: dto.limit ?? items.length,
  );
}
