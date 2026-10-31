// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LoginResponseCWProxy {
  LoginResponse id(int? id);

  LoginResponse username(String? username);

  LoginResponse email(String? email);

  LoginResponse firstName(String? firstName);

  LoginResponse lastName(String? lastName);

  LoginResponse gender(String? gender);

  LoginResponse image(String? image);

  LoginResponse accessToken(String? accessToken);

  LoginResponse refreshToken(String? refreshToken);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `LoginResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LoginResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  LoginResponse call({
    int? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? gender,
    String? image,
    String? accessToken,
    String? refreshToken,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfLoginResponse.copyWith(...)` or call `instanceOfLoginResponse.copyWith.fieldName(value)` for a single field.
class _$LoginResponseCWProxyImpl implements _$LoginResponseCWProxy {
  const _$LoginResponseCWProxyImpl(this._value);

  final LoginResponse _value;

  @override
  LoginResponse id(int? id) => call(id: id);

  @override
  LoginResponse username(String? username) => call(username: username);

  @override
  LoginResponse email(String? email) => call(email: email);

  @override
  LoginResponse firstName(String? firstName) => call(firstName: firstName);

  @override
  LoginResponse lastName(String? lastName) => call(lastName: lastName);

  @override
  LoginResponse gender(String? gender) => call(gender: gender);

  @override
  LoginResponse image(String? image) => call(image: image);

  @override
  LoginResponse accessToken(String? accessToken) =>
      call(accessToken: accessToken);

  @override
  LoginResponse refreshToken(String? refreshToken) =>
      call(refreshToken: refreshToken);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `LoginResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LoginResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  LoginResponse call({
    Object? id = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? firstName = const $CopyWithPlaceholder(),
    Object? lastName = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? accessToken = const $CopyWithPlaceholder(),
    Object? refreshToken = const $CopyWithPlaceholder(),
  }) {
    return LoginResponse(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      username: username == const $CopyWithPlaceholder()
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      firstName: firstName == const $CopyWithPlaceholder()
          ? _value.firstName
          // ignore: cast_nullable_to_non_nullable
          : firstName as String?,
      lastName: lastName == const $CopyWithPlaceholder()
          ? _value.lastName
          // ignore: cast_nullable_to_non_nullable
          : lastName as String?,
      gender: gender == const $CopyWithPlaceholder()
          ? _value.gender
          // ignore: cast_nullable_to_non_nullable
          : gender as String?,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String?,
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

extension $LoginResponseCopyWith on LoginResponse {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfLoginResponse.copyWith(...)` or `instanceOfLoginResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LoginResponseCWProxy get copyWith => _$LoginResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LoginResponse', json, ($checkedConvert) {
      final val = LoginResponse(
        id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
        username: $checkedConvert('username', (v) => v as String?),
        email: $checkedConvert('email', (v) => v as String?),
        firstName: $checkedConvert('firstName', (v) => v as String?),
        lastName: $checkedConvert('lastName', (v) => v as String?),
        gender: $checkedConvert('gender', (v) => v as String?),
        image: $checkedConvert('image', (v) => v as String?),
        accessToken: $checkedConvert('accessToken', (v) => v as String?),
        refreshToken: $checkedConvert('refreshToken', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'username': ?instance.username,
      'email': ?instance.email,
      'firstName': ?instance.firstName,
      'lastName': ?instance.lastName,
      'gender': ?instance.gender,
      'image': ?instance.image,
      'accessToken': ?instance.accessToken,
      'refreshToken': ?instance.refreshToken,
    };
