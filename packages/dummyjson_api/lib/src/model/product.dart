//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dummyjson_api/src/model/product_reviews_inner.dart';
import 'package:dummyjson_api/src/model/product_meta.dart';
import 'package:dummyjson_api/src/model/product_dimensions.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Product {
  /// Returns a new [Product] instance.
  Product({
    this.id,

    this.title,

    this.description,

    this.category,

    this.price,

    this.discountPercentage,

    this.rating,

    this.stock,

    this.tags,

    this.brand,

    this.sku,

    this.weight,

    this.dimensions,

    this.warrantyInformation,

    this.shippingInformation,

    this.availabilityStatus,

    this.reviews,

    this.returnPolicy,

    this.minimumOrderQuantity,

    this.meta,

    this.images,

    this.thumbnail,
  });

  @JsonKey(name: r'id', required: false, includeIfNull: false)
  final int? id;

  @JsonKey(name: r'title', required: false, includeIfNull: false)
  final String? title;

  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;

  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final String? category;

  @JsonKey(name: r'price', required: false, includeIfNull: false)
  final num? price;

  @JsonKey(name: r'discountPercentage', required: false, includeIfNull: false)
  final num? discountPercentage;

  @JsonKey(name: r'rating', required: false, includeIfNull: false)
  final num? rating;

  @JsonKey(name: r'stock', required: false, includeIfNull: false)
  final int? stock;

  @JsonKey(name: r'tags', required: false, includeIfNull: false)
  final List<String>? tags;

  @JsonKey(name: r'brand', required: false, includeIfNull: false)
  final String? brand;

  @JsonKey(name: r'sku', required: false, includeIfNull: false)
  final String? sku;

  @JsonKey(name: r'weight', required: false, includeIfNull: false)
  final int? weight;

  @JsonKey(name: r'dimensions', required: false, includeIfNull: false)
  final ProductDimensions? dimensions;

  @JsonKey(name: r'warrantyInformation', required: false, includeIfNull: false)
  final String? warrantyInformation;

  @JsonKey(name: r'shippingInformation', required: false, includeIfNull: false)
  final String? shippingInformation;

  @JsonKey(name: r'availabilityStatus', required: false, includeIfNull: false)
  final String? availabilityStatus;

  @JsonKey(name: r'reviews', required: false, includeIfNull: false)
  final List<ProductReviewsInner>? reviews;

  @JsonKey(name: r'returnPolicy', required: false, includeIfNull: false)
  final String? returnPolicy;

  @JsonKey(name: r'minimumOrderQuantity', required: false, includeIfNull: false)
  final int? minimumOrderQuantity;

  @JsonKey(name: r'meta', required: false, includeIfNull: false)
  final ProductMeta? meta;

  @JsonKey(name: r'images', required: false, includeIfNull: false)
  final List<String>? images;

  @JsonKey(name: r'thumbnail', required: false, includeIfNull: false)
  final String? thumbnail;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          other.id == id &&
          other.title == title &&
          other.description == description &&
          other.category == category &&
          other.price == price &&
          other.discountPercentage == discountPercentage &&
          other.rating == rating &&
          other.stock == stock &&
          other.tags == tags &&
          other.brand == brand &&
          other.sku == sku &&
          other.weight == weight &&
          other.dimensions == dimensions &&
          other.warrantyInformation == warrantyInformation &&
          other.shippingInformation == shippingInformation &&
          other.availabilityStatus == availabilityStatus &&
          other.reviews == reviews &&
          other.returnPolicy == returnPolicy &&
          other.minimumOrderQuantity == minimumOrderQuantity &&
          other.meta == meta &&
          other.images == images &&
          other.thumbnail == thumbnail;

  @override
  int get hashCode =>
      id.hashCode +
      title.hashCode +
      description.hashCode +
      category.hashCode +
      price.hashCode +
      discountPercentage.hashCode +
      rating.hashCode +
      stock.hashCode +
      tags.hashCode +
      brand.hashCode +
      sku.hashCode +
      weight.hashCode +
      dimensions.hashCode +
      warrantyInformation.hashCode +
      shippingInformation.hashCode +
      availabilityStatus.hashCode +
      reviews.hashCode +
      returnPolicy.hashCode +
      minimumOrderQuantity.hashCode +
      meta.hashCode +
      images.hashCode +
      thumbnail.hashCode;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
