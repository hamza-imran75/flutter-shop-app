sealed class Failure implements Exception {
  const Failure(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

final class OfflineFailure extends Failure {
  const OfflineFailure()
    : super('No connection. Check your internet and try again.');
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message = 'The server had a problem.']);
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super('Your session has expired.');
}

final class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure([
    super.message = 'Invalid username or password.',
  ]);
}

final class UnknownFailure extends Failure {
  const UnknownFailure() : super('Something unexpected happened.');
}

extension FailureCoercion on Object {
  Failure asFailure() =>
      this is Failure ? this as Failure : const UnknownFailure();
}
