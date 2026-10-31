// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokens.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TokensCWProxy {
  Tokens accessToken(String? accessToken);

  Tokens refreshToken(String? refreshToken);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `Tokens(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Tokens(...).copyWith(id: 12, name: "My name")
  /// ```
  Tokens call({String? accessToken, String? refreshToken});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTokens.copyWith(...)` or call `instanceOfTokens.copyWith.fieldName(value)` for a single field.
class _$TokensCWProxyImpl implements _$TokensCWProxy {
  const _$TokensCWProxyImpl(this._value);

  final Tokens _value;

  @override
  Tokens accessToken(String? accessToken) => call(accessToken: accessToken);

  @override
  Tokens refreshToken(String? refreshToken) => call(refreshToken: refreshToken);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `Tokens(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Tokens(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  Tokens call({
    Object? accessToken = const $CopyWithPlaceholder(),
    Object? refreshToken = const $CopyWithPlaceholder(),
  }) {
    return Tokens(
      accessToken: accessToken == const $CopyWithPlaceholder()
          ? _value.accessToken
          // ignore: cast_nullable_to_non_nullable
          : accessToken as String?,
      refreshToken: refreshToken == const $CopyWithPlaceholder()
          ? _value.refreshToken
          // ignore: cast_nullable_to_non_nullable
          : refreshToken as String?,
    );
  }
}

extension $TokensCopyWith on Tokens {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTokens.copyWith(...)` or `instanceOfTokens.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TokensCWProxy get copyWith => _$TokensCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tokens _$TokensFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Tokens', json, ($checkedConvert) {
      final val = Tokens(
        accessToken: $checkedConvert('accessToken', (v) => v as String?),
        refreshToken: $checkedConvert('refreshToken', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$TokensToJson(Tokens instance) => <String, dynamic>{
  'accessToken': ?instance.accessToken,
  'refreshToken': ?instance.refreshToken,
};
