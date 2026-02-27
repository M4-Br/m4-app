import 'dart:convert';
import 'package:app_flutter_miban4/core/config/auth/service/auth_service.dart';
import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:app_flutter_miban4/core/config/consts/app_header.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';

class ApiConnection {
  ApiConnection();

  Future<T> get<T>({
    required String endpoint,
    required T Function(dynamic) fromJson,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? extraHeaders,
  }) async {
    final uri = Uri.parse('${AppEndpoints.baseUrl}$endpoint').replace(
      queryParameters: queryParameters,
    );

    final headers = {
      ...const AppHeader().headers,
      if (extraHeaders != null) ...extraHeaders,
    };

    if (kDebugMode) {
      print('>>> [GET] $uri');
      print('>>> Headers: $headers');
    }

    final response = await http.get(uri, headers: headers);

    return _handleResponse(response, fromJson, 'GET');
  }

  Future<T> post<T>({
    required String endpoint,
    T Function(dynamic)? fromJson,
    Object? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? extraHeaders,
  }) async {
    final uri = Uri.parse('${AppEndpoints.baseUrl}$endpoint').replace(
      queryParameters: queryParameters,
    );

    final headers = {
      ...const AppHeader().headers,
      if (extraHeaders != null) ...extraHeaders,
    };

    if (kDebugMode) {
      print('>>> [POST] $uri');
      print('>>> Headers: $headers');
      print('>>> Body: $body');
    }

    final response = await http.post(
      uri,
      headers: headers,
      body: body != null ? json.encode(body) : null,
    );

    final parser = fromJson ?? (_) => null as T;

    return _handleResponse(response, parser, 'POST');
  }

  Future<T> delete<T>({
    required String endpoint,
    required T Function(dynamic) fromJson,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? extraHeaders,
  }) async {
    final uri = Uri.parse('${AppEndpoints.baseUrl}$endpoint').replace(
      queryParameters: queryParameters,
    );

    final headers = {
      ...const AppHeader().headers,
      if (extraHeaders != null) ...extraHeaders,
    };

    if (kDebugMode) {
      print('>>> [DELETE] $uri');
      print('>>> Headers: $headers');
      print('>>> Body: $body');
    }

    final response = await http.delete(
      uri,
      headers: headers,
      body: body != null ? json.encode(body) : null,
    );

    return _handleResponse(response, fromJson, 'DELETE');
  }

  T _handleResponse<T>(
    http.Response response,
    T Function(dynamic) fromJson,
    String method,
  ) {
    // 1. Lemos os bytes com segurança, ignorando caracteres mal codificados
    String safeBody = '';
    try {
      safeBody = utf8.decode(response.bodyBytes, allowMalformed: true);
    } catch (_) {
      safeBody = response.body; // Fallback
    }

    if (kDebugMode) {
      print('>>> [$method] Status: ${response.statusCode}');

      // 2. Evita imprimir aquele HTML gigante que trava o console
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
      // Passamos o statusCode e o safeBody para não precisar acessar response.body de novo
      final String errorMessage = _extractErrorMessage(
          response.statusCode, safeBody, response.reasonPhrase);

      AppLogger.I().error(
        'API Error $method - ${response.request?.url}',
        'Status: ${response.statusCode}, Message: $errorMessage',
        kIsWeb ? StackTrace.empty : StackTrace.current,
      );

      if (response.statusCode == 401 || response.statusCode == 403) {
        if (Get.currentRoute != AppRoutes.login) {
          AuthService.to.logout();
        }
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
