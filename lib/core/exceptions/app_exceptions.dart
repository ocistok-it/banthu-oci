class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, {this.statusCode});

  @override
  String toString() =>
      'An error occurred : $message (Status code: $statusCode)';
}
