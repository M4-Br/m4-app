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

class NotFoundException extends ApiException {
  NotFoundException({super.message = 'Recurso não encontrado'})
      : super(statusCode: 404);
}

class AlreadyExistsException extends ApiException {
  final String resourceName;
  AlreadyExistsException({required this.resourceName, String? message})
      : super(statusCode: 422, message: message ?? '$resourceName já existe.');
}

class BadRequestException extends ApiException {
  BadRequestException({super.message = 'Requisição inválida'})
      : super(statusCode: 400);
}
