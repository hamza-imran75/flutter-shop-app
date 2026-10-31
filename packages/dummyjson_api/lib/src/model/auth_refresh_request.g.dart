// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_refresh_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthRefreshRequestCWProxy {
  AuthRefreshRequest refreshToken(String? refreshToken);

  AuthRefreshRequest expiresInMins(int? expiresInMins);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AuthRefreshRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthRefreshRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthRefreshRequest call({String? refreshToken, int? expiresInMins});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthRefreshRequest.copyWith(...)` or call `instanceOfAuthRefreshRequest.copyWith.fieldName(value)` for a single field.
class _$AuthRefreshRequestCWProxyImpl implements _$AuthRefreshRequestCWProxy {
  const _$AuthRefreshRequestCWProxyImpl(this._value);

  final AuthRefreshRequest _value;

  @override
  AuthRefreshRequest refreshToken(String? refreshToken) =>
      call(refreshToken: refreshToken);

  @override
  AuthRefreshRequest expiresInMins(int? expiresInMins) =>
      call(expiresInMins: expiresInMins);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AuthRefreshRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthRefreshRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AuthRefreshRequest call({
    Object? refreshToken = const $CopyWithPlaceholder(),
    Object? expiresInMins = const $CopyWithPlaceholder(),
  }) {
    return AuthRefreshRequest(
      refreshToken: refreshToken == const $CopyWithPlaceholder()
          ? _value.refreshToken
          // ignore: cast_nullable_to_non_nullable
          : refreshToken as String?,
      expiresInMins: expiresInMins == const $CopyWithPlaceholder()
          ? _value.expiresInMins
          // ignore: cast_nullable_to_non_nullable
          : expiresInMins as int?,
    );
  }
}

extension $AuthRefreshRequestCopyWith on AuthRefreshRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthRefreshRequest.copyWith(...)` or `instanceOfAuthRefreshRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthRefreshRequestCWProxy get copyWith =>
      _$AuthRefreshRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRefreshRequest _$AuthRefreshRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AuthRefreshRequest', json, ($checkedConvert) {
      final val = AuthRefreshRequest(
        refreshToken: $checkedConvert('refreshToken', (v) => v as String?),
        expiresInMins: $checkedConvert(
          'expiresInMins',
          (v) => (v as num?)?.toInt(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AuthRefreshRequestToJson(AuthRefreshRequest instance) =>
    <String, dynamic>{
      'refreshToken': ?instance.refreshToken,
      'expiresInMins': ?instance.expiresInMins,
    };
