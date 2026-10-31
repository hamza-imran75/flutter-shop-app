// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthLoginRequestCWProxy {
  AuthLoginRequest username(String username);

  AuthLoginRequest password(String password);

  AuthLoginRequest expiresInMins(int? expiresInMins);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AuthLoginRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthLoginRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthLoginRequest call({String username, String password, int? expiresInMins});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthLoginRequest.copyWith(...)` or call `instanceOfAuthLoginRequest.copyWith.fieldName(value)` for a single field.
class _$AuthLoginRequestCWProxyImpl implements _$AuthLoginRequestCWProxy {
  const _$AuthLoginRequestCWProxyImpl(this._value);

  final AuthLoginRequest _value;

  @override
  AuthLoginRequest username(String username) => call(username: username);

  @override
  AuthLoginRequest password(String password) => call(password: password);

  @override
  AuthLoginRequest expiresInMins(int? expiresInMins) =>
      call(expiresInMins: expiresInMins);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AuthLoginRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthLoginRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AuthLoginRequest call({
    Object? username = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? expiresInMins = const $CopyWithPlaceholder(),
  }) {
    return AuthLoginRequest(
      username: username == const $CopyWithPlaceholder() || username == null
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String,
      password: password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
      expiresInMins: expiresInMins == const $CopyWithPlaceholder()
          ? _value.expiresInMins
          // ignore: cast_nullable_to_non_nullable
          : expiresInMins as int?,
    );
  }
}

extension $AuthLoginRequestCopyWith on AuthLoginRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthLoginRequest.copyWith(...)` or `instanceOfAuthLoginRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthLoginRequestCWProxy get copyWith => _$AuthLoginRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthLoginRequest _$AuthLoginRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AuthLoginRequest', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['username', 'password']);
      final val = AuthLoginRequest(
        username: $checkedConvert('username', (v) => v as String),
        password: $checkedConvert('password', (v) => v as String),
        expiresInMins: $checkedConvert(
          'expiresInMins',
          (v) => (v as num?)?.toInt(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AuthLoginRequestToJson(AuthLoginRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'expiresInMins': ?instance.expiresInMins,
    };
