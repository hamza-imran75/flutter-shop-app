// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_reviews_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductReviewsInnerCWProxy {
  ProductReviewsInner rating(int? rating);

  ProductReviewsInner comment(String? comment);

  ProductReviewsInner date(String? date);

  ProductReviewsInner reviewerName(String? reviewerName);

  ProductReviewsInner reviewerEmail(String? reviewerEmail);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ProductReviewsInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ProductReviewsInner(...).copyWith(id: 12, name: "My name")
  /// ```
  ProductReviewsInner call({
    int? rating,
    String? comment,
    String? date,
    String? reviewerName,
    String? reviewerEmail,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfProductReviewsInner.copyWith(...)` or call `instanceOfProductReviewsInner.copyWith.fieldName(value)` for a single field.
class _$ProductReviewsInnerCWProxyImpl implements _$ProductReviewsInnerCWProxy {
  const _$ProductReviewsInnerCWProxyImpl(this._value);

  final ProductReviewsInner _value;

  @override
  ProductReviewsInner rating(int? rating) => call(rating: rating);

  @override
  ProductReviewsInner comment(String? comment) => call(comment: comment);

  @override
  ProductReviewsInner date(String? date) => call(date: date);

  @override
  ProductReviewsInner reviewerName(String? reviewerName) =>
      call(reviewerName: reviewerName);

  @override
  ProductReviewsInner reviewerEmail(String? reviewerEmail) =>
      call(reviewerEmail: reviewerEmail);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ProductReviewsInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ProductReviewsInner(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ProductReviewsInner call({
    Object? rating = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? reviewerName = const $CopyWithPlaceholder(),
    Object? reviewerEmail = const $CopyWithPlaceholder(),
  }) {
    return ProductReviewsInner(
      rating: rating == const $CopyWithPlaceholder()
          ? _value.rating
          // ignore: cast_nullable_to_non_nullable
          : rating as int?,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String?,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String?,
      reviewerName: reviewerName == const $CopyWithPlaceholder()
          ? _value.reviewerName
          // ignore: cast_nullable_to_non_nullable
          : reviewerName as String?,
      reviewerEmail: reviewerEmail == const $CopyWithPlaceholder()
          ? _value.reviewerEmail
          // ignore: cast_nullable_to_non_nullable
          : reviewerEmail as String?,
    );
  }
}

extension $ProductReviewsInnerCopyWith on ProductReviewsInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfProductReviewsInner.copyWith(...)` or `instanceOfProductReviewsInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductReviewsInnerCWProxy get copyWith =>
      _$ProductReviewsInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductReviewsInner _$ProductReviewsInnerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ProductReviewsInner', json, ($checkedConvert) {
      final val = ProductReviewsInner(
        rating: $checkedConvert('rating', (v) => (v as num?)?.toInt()),
        comment: $checkedConvert('comment', (v) => v as String?),
        date: $checkedConvert('date', (v) => v as String?),
        reviewerName: $checkedConvert('reviewerName', (v) => v as String?),
        reviewerEmail: $checkedConvert('reviewerEmail', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ProductReviewsInnerToJson(
  ProductReviewsInner instance,
) => <String, dynamic>{
  'rating': ?instance.rating,
  'comment': ?instance.comment,
  'date': ?instance.date,
  'reviewerName': ?instance.reviewerName,
  'reviewerEmail': ?instance.reviewerEmail,
};
