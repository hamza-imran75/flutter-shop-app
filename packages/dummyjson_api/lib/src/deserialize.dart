import 'package:dummyjson_api/src/model/auth_login_request.dart';
import 'package:dummyjson_api/src/model/auth_refresh_request.dart';
import 'package:dummyjson_api/src/model/auth_user.dart';
import 'package:dummyjson_api/src/model/error.dart';
import 'package:dummyjson_api/src/model/login_response.dart';
import 'package:dummyjson_api/src/model/product.dart';
import 'package:dummyjson_api/src/model/product_dimensions.dart';
import 'package:dummyjson_api/src/model/product_list.dart';
import 'package:dummyjson_api/src/model/product_meta.dart';
import 'package:dummyjson_api/src/model/product_reviews_inner.dart';
import 'package:dummyjson_api/src/model/tokens.dart';

final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

ReturnType deserialize<ReturnType, BaseType>(
  dynamic value,
  String targetType, {
  bool growable = true,
}) {
  switch (targetType) {
    case 'String':
      return '$value' as ReturnType;
    case 'int':
      return (value is int ? value : int.parse('$value')) as ReturnType;
    case 'bool':
      if (value is bool) {
        return value as ReturnType;
      }
      final valueString = '$value'.toLowerCase();
      return (valueString == 'true' || valueString == '1') as ReturnType;
    case 'double':
      return (value is double ? value : double.parse('$value')) as ReturnType;
    case 'AuthLoginRequest':
      return AuthLoginRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AuthRefreshRequest':
      return AuthRefreshRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AuthUser':
      return AuthUser.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Error':
      return Error.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'LoginResponse':
      return LoginResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Product':
      return Product.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ProductDimensions':
      return ProductDimensions.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ProductList':
      return ProductList.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ProductMeta':
      return ProductMeta.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ProductReviewsInner':
      return ProductReviewsInner.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Tokens':
      return Tokens.fromJson(value as Map<String, dynamic>) as ReturnType;
    default:
      RegExpMatch? match;

      if (value is List && (match = _regList.firstMatch(targetType)) != null) {
        targetType = match![1]!; // ignore: parameter_assignments
        return value
                .map<BaseType>(
                  (dynamic v) => deserialize<BaseType, BaseType>(
                    v,
                    targetType,
                    growable: growable,
                  ),
                )
                .toList(growable: growable)
            as ReturnType;
      }
      if (value is Set && (match = _regSet.firstMatch(targetType)) != null) {
        targetType = match![1]!; // ignore: parameter_assignments
        return value
                .map<BaseType>(
                  (dynamic v) => deserialize<BaseType, BaseType>(
                    v,
                    targetType,
                    growable: growable,
                  ),
                )
                .toSet()
            as ReturnType;
      }
      if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
        targetType = match![1]!.trim(); // ignore: parameter_assignments
        return Map<String, BaseType>.fromIterables(
          value.keys as Iterable<String>,
          value.values.map(
            (dynamic v) => deserialize<BaseType, BaseType>(
              v,
              targetType,
              growable: growable,
            ),
          ),
        ) as ReturnType;
      }
      break;
  }
  throw Exception('Cannot deserialize');
}
