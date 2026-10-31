//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_dimensions.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProductDimensions {
  /// Returns a new [ProductDimensions] instance.
  ProductDimensions({this.width, this.height, this.depth});

  @JsonKey(name: r'width', required: false, includeIfNull: false)
  final num? width;

  @JsonKey(name: r'height', required: false, includeIfNull: false)
  final num? height;

  @JsonKey(name: r'depth', required: false, includeIfNull: false)
  final num? depth;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDimensions &&
          other.width == width &&
          other.height == height &&
          other.depth == depth;

  @override
  int get hashCode => width.hashCode + height.hashCode + depth.hashCode;

  factory ProductDimensions.fromJson(Map<String, dynamic> json) =>
      _$ProductDimensionsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDimensionsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
