//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_meta.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProductMeta {
  /// Returns a new [ProductMeta] instance.
  ProductMeta({this.createdAt, this.updatedAt, this.barcode, this.qrCode});

  @JsonKey(name: r'createdAt', required: false, includeIfNull: false)
  final String? createdAt;

  @JsonKey(name: r'updatedAt', required: false, includeIfNull: false)
  final String? updatedAt;

  @JsonKey(name: r'barcode', required: false, includeIfNull: false)
  final String? barcode;

  @JsonKey(name: r'qrCode', required: false, includeIfNull: false)
  final String? qrCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductMeta &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.barcode == barcode &&
          other.qrCode == qrCode;

  @override
  int get hashCode =>
      createdAt.hashCode +
      updatedAt.hashCode +
      barcode.hashCode +
      qrCode.hashCode;

  factory ProductMeta.fromJson(Map<String, dynamic> json) =>
      _$ProductMetaFromJson(json);

  Map<String, dynamic> toJson() => _$ProductMetaToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
