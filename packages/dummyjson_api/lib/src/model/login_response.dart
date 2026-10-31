//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LoginResponse {
  /// Returns a new [LoginResponse] instance.
  LoginResponse({
    this.id,

    this.username,

    this.email,

    this.firstName,

    this.lastName,

    this.gender,

    this.image,

    this.accessToken,

    this.refreshToken,
  });

  @JsonKey(name: r'id', required: false, includeIfNull: false)
  final int? id;

  @JsonKey(name: r'username', required: false, includeIfNull: false)
  final String? username;

  @JsonKey(name: r'email', required: false, includeIfNull: false)
  final String? email;

  @JsonKey(name: r'firstName', required: false, includeIfNull: false)
  final String? firstName;

  @JsonKey(name: r'lastName', required: false, includeIfNull: false)
  final String? lastName;

  @JsonKey(name: r'gender', required: false, includeIfNull: false)
  final String? gender;

  @JsonKey(name: r'image', required: false, includeIfNull: false)
  final String? image;

  @JsonKey(name: r'accessToken', required: false, includeIfNull: false)
  final String? accessToken;

  @JsonKey(name: r'refreshToken', required: false, includeIfNull: false)
  final String? refreshToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginResponse &&
          other.id == id &&
          other.username == username &&
          other.email == email &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.gender == gender &&
          other.image == image &&
          other.accessToken == accessToken &&
          other.refreshToken == refreshToken;

  @override
  int get hashCode =>
      id.hashCode +
      username.hashCode +
      email.hashCode +
      firstName.hashCode +
      lastName.hashCode +
      gender.hashCode +
      image.hashCode +
      accessToken.hashCode +
      refreshToken.hashCode;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
