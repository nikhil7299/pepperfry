class Failure {
  final int statusCode;
  final String message;
  final StackTrace stackTrace;
  Failure({
    required this.statusCode,
    required this.message,
    required this.stackTrace,
  });
}
