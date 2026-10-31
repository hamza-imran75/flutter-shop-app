// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthUserCWProxy {
  AuthUser id(int? id);

  AuthUser username(String? username);

  AuthUser email(String? email);

  AuthUser firstName(String? firstName);

  AuthUser lastName(String? lastName);

  AuthUser gender(String? gender);

  AuthUser image(String? image);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AuthUser(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthUser(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthUser call({
    int? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? gender,
    String? image,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthUser.copyWith(...)` or call `instanceOfAuthUser.copyWith.fieldName(value)` for a single field.
class _$AuthUserCWProxyImpl implements _$AuthUserCWProxy {
  const _$AuthUserCWProxyImpl(this._value);

  final AuthUser _value;

  @override
  AuthUser id(int? id) => call(id: id);

  @override
  AuthUser username(String? username) => call(username: username);

  @override
  AuthUser email(String? email) => call(email: email);

  @override
  AuthUser firstName(String? firstName) => call(firstName: firstName);

  @override
  AuthUser lastName(String? lastName) => call(lastName: lastName);

  @override
  AuthUser gender(String? gender) => call(gender: gender);

  @override
  AuthUser image(String? image) => call(image: image);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AuthUser(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthUser(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AuthUser call({
    Object? id = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? firstName = const $CopyWithPlaceholder(),
    Object? lastName = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
  }) {
    return AuthUser(
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
    );
  }
}

extension $AuthUserCopyWith on AuthUser {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthUser.copyWith(...)` or `instanceOfAuthUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthUserCWProxy get copyWith => _$AuthUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUser _$AuthUserFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AuthUser', json, ($checkedConvert) {
      final val = AuthUser(
        id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
        username: $checkedConvert('username', (v) => v as String?),
        email: $checkedConvert('email', (v) => v as String?),
        firstName: $checkedConvert('firstName', (v) => v as String?),
        lastName: $checkedConvert('lastName', (v) => v as String?),
        gender: $checkedConvert('gender', (v) => v as String?),
        image: $checkedConvert('image', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$AuthUserToJson(AuthUser instance) => <String, dynamic>{
  'id': ?instance.id,
  'username': ?instance.username,
  'email': ?instance.email,
  'firstName': ?instance.firstName,
  'lastName': ?instance.lastName,
  'gender': ?instance.gender,
  'image': ?instance.image,
};
