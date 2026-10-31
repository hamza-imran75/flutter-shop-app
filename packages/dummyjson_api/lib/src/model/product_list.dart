//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dummyjson_api/src/model/product.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProductList {
  /// Returns a new [ProductList] instance.
  ProductList({this.products, this.total, this.skip, this.limit});

  @JsonKey(name: r'products', required: false, includeIfNull: false)
  final List<Product>? products;

  @JsonKey(name: r'total', required: false, includeIfNull: false)
  final int? total;

  @JsonKey(name: r'skip', required: false, includeIfNull: false)
  final int? skip;

  @JsonKey(name: r'limit', required: false, includeIfNull: false)
  final int? limit;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductList &&
          other.products == products &&
          other.total == total &&
          other.skip == skip &&
          other.limit == limit;

  @override
  int get hashCode =>
      products.hashCode + total.hashCode + skip.hashCode + limit.hashCode;

  factory ProductList.fromJson(Map<String, dynamic> json) =>
      _$ProductListFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
