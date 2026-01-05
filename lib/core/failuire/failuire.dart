abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// ✅ Firebase Failure
class FirebaseFailure extends Failure {
  const FirebaseFailure(super.message);
}
