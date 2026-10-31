// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductListCWProxy {
  ProductList products(List<Product>? products);

  ProductList total(int? total);

  ProductList skip(int? skip);

  ProductList limit(int? limit);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ProductList(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ProductList(...).copyWith(id: 12, name: "My name")
  /// ```
  ProductList call({
    List<Product>? products,
    int? total,
    int? skip,
    int? limit,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfProductList.copyWith(...)` or call `instanceOfProductList.copyWith.fieldName(value)` for a single field.
class _$ProductListCWProxyImpl implements _$ProductListCWProxy {
  const _$ProductListCWProxyImpl(this._value);

  final ProductList _value;

  @override
  ProductList products(List<Product>? products) => call(products: products);

  @override
  ProductList total(int? total) => call(total: total);

  @override
  ProductList skip(int? skip) => call(skip: skip);

  @override
  ProductList limit(int? limit) => call(limit: limit);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ProductList(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ProductList(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ProductList call({
    Object? products = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
    Object? skip = const $CopyWithPlaceholder(),
    Object? limit = const $CopyWithPlaceholder(),
  }) {
    return ProductList(
      products: products == const $CopyWithPlaceholder()
          ? _value.products
          // ignore: cast_nullable_to_non_nullable
          : products as List<Product>?,
      total: total == const $CopyWithPlaceholder()
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as int?,
      skip: skip == const $CopyWithPlaceholder()
          ? _value.skip
          // ignore: cast_nullable_to_non_nullable
          : skip as int?,
      limit: limit == const $CopyWithPlaceholder()
          ? _value.limit
          // ignore: cast_nullable_to_non_nullable
          : limit as int?,
    );
  }
}

extension $ProductListCopyWith on ProductList {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfProductList.copyWith(...)` or `instanceOfProductList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductListCWProxy get copyWith => _$ProductListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductList _$ProductListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ProductList', json, ($checkedConvert) {
      final val = ProductList(
        products: $checkedConvert(
          'products',
          (v) => (v as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        total: $checkedConvert('total', (v) => (v as num?)?.toInt()),
        skip: $checkedConvert('skip', (v) => (v as num?)?.toInt()),
        limit: $checkedConvert('limit', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$ProductListToJson(ProductList instance) =>
    <String, dynamic>{
      'products': ?instance.products?.map((e) => e.toJson()).toList(),
      'total': ?instance.total,
      'skip': ?instance.skip,
      'limit': ?instance.limit,
    };
