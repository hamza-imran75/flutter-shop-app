//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_refresh_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthRefreshRequest {
  /// Returns a new [AuthRefreshRequest] instance.
  AuthRefreshRequest({this.refreshToken, this.expiresInMins});

  @JsonKey(name: r'refreshToken', required: false, includeIfNull: false)
  final String? refreshToken;

  @JsonKey(name: r'expiresInMins', required: false, includeIfNull: false)
  final int? expiresInMins;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthRefreshRequest &&
          other.refreshToken == refreshToken &&
          other.expiresInMins == expiresInMins;

  @override
  int get hashCode => refreshToken.hashCode + expiresInMins.hashCode;

  factory AuthRefreshRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRefreshRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRefreshRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
