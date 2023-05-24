class ServerFailure implements Exception {
  final String message;
  ServerFailure([this.message = "Server failure occurred"]);
}
