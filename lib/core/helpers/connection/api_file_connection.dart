import 'dart:convert';
// Removemos o import 'dart:io' que quebrava a Web!

import 'package:app_flutter_miban4/core/config/consts/app_header.dart';
import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart'; // Adicionado para suportar XFile

class ApiMultipartConnection {
  ApiMultipartConnection();

  Future<T> post<T>({
    required String endpoint,
    required T Function(dynamic) fromJson,
    Map<String, String>? fields,
    Map<String, XFile>? files, // Agora recebe XFile em vez de File
    Map<String, dynamic>? queryParameters,
    Map<String, String>? extraHeaders,
    String httpMethod = 'POST',
  }) async {
    final uri = Uri.parse('${AppEndpoints.baseUrl}$endpoint').replace(
      queryParameters: queryParameters,
    );

    final headers = {
      ...const AppHeader().headers,
      if (extraHeaders != null) ...extraHeaders,
    };
    headers.remove('Content-Type');

    if (kDebugMode) {
      print('>>> [MULTIPART $httpMethod] $uri');
      print('>>> Headers: $headers');
      print('>>> Fields: $fields');
      print('>>> Files: ${files?.keys.toList()}');
    }

    var request = http.MultipartRequest(httpMethod, uri);
    request.headers.addAll(headers);

    if (fields != null) {
      request.fields.addAll(fields);
    }

    if (files != null) {
      for (var entry in files.entries) {
        final fieldName = entry.key;
        final xFile = entry.value;

        // Extrai os bytes da memória de forma segura para Web/Mobile
        final bytes = await xFile.readAsBytes();

        var multipartFile = http.MultipartFile.fromBytes(
          fieldName,
          bytes,
          filename: xFile.name, // O XFile já sabe o nome dele
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(multipartFile);
      }
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return _handleResponse(response, fromJson, 'MULTIPART $httpMethod');
  }

  T _handleResponse<T>(
    http.Response response,
    T Function(dynamic) fromJson,
    String method,
  ) {
    // Blindagem para evitar crash com caracteres inválidos na Web
    String safeBody = '';
    try {
      safeBody = utf8.decode(response.bodyBytes, allowMalformed: true);
    } catch (_) {
      safeBody = response.body;
    }

    if (kDebugMode) {
      print('>>> [$method] Status: ${response.statusCode}');
      if (safeBody.trim().startsWith('<!DOCTYPE html>')) {
        print(
            '>>> [$method] Response: [Página HTML de Erro Retornada - Ocultada do Log]');
      } else {
        print('>>> [$method] Response: $safeBody');
      }
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        final decodedBody = safeBody.isNotEmpty ? json.decode(safeBody) : null;
        return fromJson(decodedBody);
      } catch (e, s) {
        AppLogger.I().error('JSON Parsing Error on Success', e, s);
        throw ApiException(
            message: 'Erro ao processar a resposta do servidor.',
            statusCode: response.statusCode);
      }
    } else {
      final String errorMessage = _extractErrorMessage(
          response.statusCode, safeBody, response.reasonPhrase);

      AppLogger.I().error(
          'API Error $method - ${response.request?.url}',
          'Status: ${response.statusCode}, Message: $errorMessage',
          kIsWeb
              ? StackTrace.empty
              : StackTrace.current); // Evita o crash do Get Current

      if (response.statusCode == 401 || response.statusCode == 403) {
        throw UnauthorizedException(message: errorMessage);
      }

      if (response.statusCode >= 500) {
        throw ServerException(message: errorMessage);
      }

      throw ApiException(
        message: errorMessage,
        statusCode: response.statusCode,
      );
    }
  }

  String _extractErrorMessage(
      int statusCode, String safeBody, String? reasonPhrase) {
    if (statusCode >= 500) {
      return 'Ocorreu um erro em nossos servidores. Por favor, tente novamente mais tarde.';
    }

    try {
      final decodedBody = json.decode(safeBody);
      if (decodedBody is Map) {
        if (decodedBody.containsKey('message') &&
            decodedBody['message'] is String) {
          return decodedBody['message'];
        }
        if (decodedBody.containsKey('error') &&
            decodedBody['error'] is String) {
          return decodedBody['error'];
        }
        if (decodedBody.containsKey('detail') &&
            decodedBody['detail'] is String) {
          return decodedBody['detail'];
        }
      }
    } catch (_) {
      if (safeBody.isNotEmpty &&
          !safeBody.trim().startsWith('<!DOCTYPE html>')) {
        return safeBody;
      }
    }

    if (reasonPhrase != null && reasonPhrase.isNotEmpty) {
      return reasonPhrase;
    }

    return 'Ocorreu um erro inesperado. Por favor, contate o suporte.';
  }
}
