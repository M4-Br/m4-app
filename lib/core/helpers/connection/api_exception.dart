class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException({required this.message, this.statusCode});
  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(
      {super.message = 'Sessão expirada. Faça login novamente.'})
      : super(statusCode: 401);
}

class ServerException extends ApiException {
  ServerException({super.message = 'Verifique sua conexão e tente novamente'})
      : super(statusCode: 500);
}
