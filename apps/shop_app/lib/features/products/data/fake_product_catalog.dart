import 'dart:convert';

import 'package:flutter/services.dart';

import '../domain/product.dart';

/// Parses the bundled dummyjson snapshot. Phase 2's generated API models map
/// to the domain at their own boundary, so the domain has no `fromJson`.
class FakeProductCatalog {
  FakeProductCatalog._(this.products);

  final List<Product> products;

  static Future<FakeProductCatalog> load() async {
    final raw = await rootBundle.loadString('assets/fake/products.json');
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    return FakeProductCatalog._(list.map(_parse).toList(growable: false));
  }

  static Product _parse(Map<String, dynamic> json) => Product(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        price: (json['price'] as num).toDouble(),
        discountPercentage: (json['discountPercentage'] as num).toDouble(),
        rating: (json['rating'] as num).toDouble(),
        stock: json['stock'] as int,
        brand: json['brand'] as String?,
        category: json['category'] as String,
        thumbnail: json['thumbnail'] as String,
        images: (json['images'] as List).cast<String>(),
        tags: (json['tags'] as List).cast<String>(),
      );
}
