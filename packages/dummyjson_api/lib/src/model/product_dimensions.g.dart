// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dimensions.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductDimensionsCWProxy {
  ProductDimensions width(num? width);

  ProductDimensions height(num? height);

  ProductDimensions depth(num? depth);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ProductDimensions(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ProductDimensions(...).copyWith(id: 12, name: "My name")
  /// ```
  ProductDimensions call({num? width, num? height, num? depth});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfProductDimensions.copyWith(...)` or call `instanceOfProductDimensions.copyWith.fieldName(value)` for a single field.
class _$ProductDimensionsCWProxyImpl implements _$ProductDimensionsCWProxy {
  const _$ProductDimensionsCWProxyImpl(this._value);

  final ProductDimensions _value;

  @override
  ProductDimensions width(num? width) => call(width: width);

  @override
  ProductDimensions height(num? height) => call(height: height);

  @override
  ProductDimensions depth(num? depth) => call(depth: depth);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ProductDimensions(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ProductDimensions(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ProductDimensions call({
    Object? width = const $CopyWithPlaceholder(),
    Object? height = const $CopyWithPlaceholder(),
    Object? depth = const $CopyWithPlaceholder(),
  }) {
    return ProductDimensions(
      width: width == const $CopyWithPlaceholder()
          ? _value.width
          // ignore: cast_nullable_to_non_nullable
          : width as num?,
      height: height == const $CopyWithPlaceholder()
          ? _value.height
          // ignore: cast_nullable_to_non_nullable
          : height as num?,
      depth: depth == const $CopyWithPlaceholder()
          ? _value.depth
          // ignore: cast_nullable_to_non_nullable
          : depth as num?,
    );
  }
}

extension $ProductDimensionsCopyWith on ProductDimensions {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfProductDimensions.copyWith(...)` or `instanceOfProductDimensions.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductDimensionsCWProxy get copyWith =>
      _$ProductDimensionsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDimensions _$ProductDimensionsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ProductDimensions', json, ($checkedConvert) {
      final val = ProductDimensions(
        width: $checkedConvert('width', (v) => v as num?),
        height: $checkedConvert('height', (v) => v as num?),
        depth: $checkedConvert('depth', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$ProductDimensionsToJson(ProductDimensions instance) =>
    <String, dynamic>{
      'width': ?instance.width,
      'height': ?instance.height,
      'depth': ?instance.depth,
    };
