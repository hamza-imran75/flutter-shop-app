import '../../../core/connectivity_status.dart';
import '../../../core/failure.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_session.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({required this.connectivity});

  final ConnectivityStatus connectivity;
  AuthSession? _session;

  static const _user = User(
    id: 1,
    username: 'emilys',
    firstName: 'Emily',
    lastName: 'Johnson',
    email: 'emily.johnson@x.dummyjson.com',
    image: 'https://dummyjson.com/icon/emilys/128',
  );

  @override
  Future<AuthSession> login({
    required String username,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!connectivity.online.value) throw const OfflineFailure();
    if (username != 'emilys' || password != 'emilyspass') {
      throw const InvalidCredentialsFailure();
    }
    return _session = const AuthSession(
      user: _user,
      accessToken: 'fake-access-token',
      refreshToken: 'fake-refresh-token',
    );
  }

  @override
  Future<void> logout() async => _session = null;

  @override
  Future<AuthSession?> restoreSession() async => _session;
}
