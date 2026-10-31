//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_reviews_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProductReviewsInner {
  /// Returns a new [ProductReviewsInner] instance.
  ProductReviewsInner({
    this.rating,

    this.comment,

    this.date,

    this.reviewerName,

    this.reviewerEmail,
  });

  @JsonKey(name: r'rating', required: false, includeIfNull: false)
  final int? rating;

  @JsonKey(name: r'comment', required: false, includeIfNull: false)
  final String? comment;

  @JsonKey(name: r'date', required: false, includeIfNull: false)
  final String? date;

  @JsonKey(name: r'reviewerName', required: false, includeIfNull: false)
  final String? reviewerName;

  @JsonKey(name: r'reviewerEmail', required: false, includeIfNull: false)
  final String? reviewerEmail;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductReviewsInner &&
          other.rating == rating &&
          other.comment == comment &&
          other.date == date &&
          other.reviewerName == reviewerName &&
          other.reviewerEmail == reviewerEmail;

  @override
  int get hashCode =>
      rating.hashCode +
      comment.hashCode +
      date.hashCode +
      reviewerName.hashCode +
      reviewerEmail.hashCode;

  factory ProductReviewsInner.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewsInnerFromJson(json);

  Map<String, dynamic> toJson() => _$ProductReviewsInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
