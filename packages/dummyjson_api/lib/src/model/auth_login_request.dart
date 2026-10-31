//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_login_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthLoginRequest {
  /// Returns a new [AuthLoginRequest] instance.
  AuthLoginRequest({
    required this.username,

    required this.password,

    this.expiresInMins,
  });

  @JsonKey(name: r'username', required: true, includeIfNull: false)
  final String username;

  @JsonKey(name: r'password', required: true, includeIfNull: false)
  final String password;

  @JsonKey(name: r'expiresInMins', required: false, includeIfNull: false)
  final int? expiresInMins;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthLoginRequest &&
          other.username == username &&
          other.password == password &&
          other.expiresInMins == expiresInMins;

  @override
  int get hashCode =>
      username.hashCode + password.hashCode + expiresInMins.hashCode;

  factory AuthLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthLoginRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
