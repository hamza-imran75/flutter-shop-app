// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ErrorCWProxy {
  Error message(String? message);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `Error(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Error(...).copyWith(id: 12, name: "My name")
  /// ```
  Error call({String? message});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfError.copyWith(...)` or call `instanceOfError.copyWith.fieldName(value)` for a single field.
class _$ErrorCWProxyImpl implements _$ErrorCWProxy {
  const _$ErrorCWProxyImpl(this._value);

  final Error _value;

  @override
  Error message(String? message) => call(message: message);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `Error(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Error(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  Error call({Object? message = const $CopyWithPlaceholder()}) {
    return Error(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
    );
  }
}

extension $ErrorCopyWith on Error {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfError.copyWith(...)` or `instanceOfError.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ErrorCWProxy get copyWith => _$ErrorCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Error _$ErrorFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Error',
  json,
  ($checkedConvert) {
    final val = Error(message: $checkedConvert('message', (v) => v as String?));
    return val;
  },
);

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
  'message': ?instance.message,
};
