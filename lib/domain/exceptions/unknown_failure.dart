class UnknownFailure implements Exception {
  final String message;
  UnknownFailure([this.message = "An unknown failure occurred"]);
}
