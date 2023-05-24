class NetworkFailure implements Exception {
  final String message;
  NetworkFailure([this.message = "Network failure occurred"]);
}
