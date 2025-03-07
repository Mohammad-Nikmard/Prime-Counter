class ApiException implements Exception {
  final String message;
  final int? errorCode;

  const ApiException({
    required this.message,
    this.errorCode,
  });
}
