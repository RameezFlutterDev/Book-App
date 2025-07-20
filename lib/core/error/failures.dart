abstract class Failure {
  final String message;

  const Failure(this.message);
}

// General failure (e.g., for unexpected errors)
class GeneralFailure extends Failure {
  const GeneralFailure(String message) : super(message);
}

// Server/API failure (e.g., API call error, status != 200)
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

// Cache/database failure (e.g., SQLite/Floor failure)
class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}
