import 'package:dummyjson_api/dummyjson_api.dart';

import '../domain/auth_session.dart';

User userFromDto(AuthUser dto) => User(
  id: dto.id ?? 0,
  username: dto.username ?? '',
  firstName: dto.firstName ?? '',
  lastName: dto.lastName ?? '',
  email: dto.email ?? '',
  image: dto.image ?? '',
);

User userFromLogin(LoginResponse dto) => User(
  id: dto.id ?? 0,
  username: dto.username ?? '',
  firstName: dto.firstName ?? '',
  lastName: dto.lastName ?? '',
  email: dto.email ?? '',
  image: dto.image ?? '',
);
