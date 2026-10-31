// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_meta.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductMetaCWProxy {
  ProductMeta createdAt(String? createdAt);

  ProductMeta updatedAt(String? updatedAt);

  ProductMeta barcode(String? barcode);

  ProductMeta qrCode(String? qrCode);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ProductMeta(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ProductMeta(...).copyWith(id: 12, name: "My name")
  /// ```
  ProductMeta call({
    String? createdAt,
    String? updatedAt,
    String? barcode,
    String? qrCode,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfProductMeta.copyWith(...)` or call `instanceOfProductMeta.copyWith.fieldName(value)` for a single field.
class _$ProductMetaCWProxyImpl implements _$ProductMetaCWProxy {
  const _$ProductMetaCWProxyImpl(this._value);

  final ProductMeta _value;

  @override
  ProductMeta createdAt(String? createdAt) => call(createdAt: createdAt);

  @override
  ProductMeta updatedAt(String? updatedAt) => call(updatedAt: updatedAt);

  @override
  ProductMeta barcode(String? barcode) => call(barcode: barcode);

  @override
  ProductMeta qrCode(String? qrCode) => call(qrCode: qrCode);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ProductMeta(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ProductMeta(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ProductMeta call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? barcode = const $CopyWithPlaceholder(),
    Object? qrCode = const $CopyWithPlaceholder(),
  }) {
    return ProductMeta(
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as String?,
      barcode: barcode == const $CopyWithPlaceholder()
          ? _value.barcode
          // ignore: cast_nullable_to_non_nullable
          : barcode as String?,
      qrCode: qrCode == const $CopyWithPlaceholder()
          ? _value.qrCode
          // ignore: cast_nullable_to_non_nullable
          : qrCode as String?,
    );
  }
}

extension $ProductMetaCopyWith on ProductMeta {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfProductMeta.copyWith(...)` or `instanceOfProductMeta.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductMetaCWProxy get copyWith => _$ProductMetaCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductMeta _$ProductMetaFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ProductMeta', json, ($checkedConvert) {
      final val = ProductMeta(
        createdAt: $checkedConvert('createdAt', (v) => v as String?),
        updatedAt: $checkedConvert('updatedAt', (v) => v as String?),
        barcode: $checkedConvert('barcode', (v) => v as String?),
        qrCode: $checkedConvert('qrCode', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ProductMetaToJson(ProductMeta instance) =>
    <String, dynamic>{
      'createdAt': ?instance.createdAt,
      'updatedAt': ?instance.updatedAt,
      'barcode': ?instance.barcode,
      'qrCode': ?instance.qrCode,
    };
