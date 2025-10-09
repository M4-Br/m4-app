import 'dart:convert';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:app_flutter_miban4/core/config/consts/app_header.dart';
import 'package:app_flutter_miban4/core/config/consts/app_url.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';

class ApiConnection {
  ApiConnection();

  Future<T> get<T>({
    required String endpoint,
    required T Function(dynamic) fromJson,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? extraHeaders,
  }) async {
    final uri = Uri.parse('${UrlConst.urlBase}$endpoint').replace(
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
    required T Function(dynamic) fromJson,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? extraHeaders,
  }) async {
    final uri = Uri.parse('${UrlConst.urlBase}$endpoint').replace(
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

    return _handleResponse(response, fromJson, 'POST');
  }

  Future<T> delete<T>({
    required String endpoint,
    required T Function(dynamic) fromJson,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? extraHeaders,
  }) async {
    final uri = Uri.parse('${UrlConst.urlBase}$endpoint').replace(
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
    if (kDebugMode) {
      print('>>> [$method] Status: ${response.statusCode}');
      print('>>> [$method] Response: ${response.body}');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        final decodedBody =
            response.body.isNotEmpty ? json.decode(response.body) : null;
        return fromJson(decodedBody);
      } catch (e, s) {
        AppLogger.I().error('JSON Parsing Error on Success', e, s);
        throw ApiException(
            message: 'Erro ao processar a resposta do servidor.',
            statusCode: response.statusCode);
      }
    } else {
      final String errorMessage = _extractErrorMessage(response);

      AppLogger.I().error(
          'API Error $method - ${response.request?.url}',
          'Status: ${response.statusCode}, Message: $errorMessage',
          StackTrace.current);

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

  String _extractErrorMessage(http.Response response) {
    if (response.statusCode >= 500) {
      return 'Ocorreu um erro em nossos servidores. Por favor, tente novamente mais tarde.';
    }

    try {
      final decodedBody = json.decode(response.body);
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
      if (response.body.isNotEmpty &&
          !response.body.trim().startsWith('<!DOCTYPE html>')) {
        return response.body;
      }
    }

    if (response.reasonPhrase != null && response.reasonPhrase!.isNotEmpty) {
      return response.reasonPhrase!;
    }

    return 'Ocorreu um erro inesperado. Por favor, contate o suporte.';
  }
}
