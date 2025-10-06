import 'dart:convert';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
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

    try {
      final decodedBody =
          response.body.isNotEmpty ? json.decode(response.body) : null;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return fromJson(decodedBody);
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final message = decodedBody is Map && decodedBody.containsKey('message')
            ? decodedBody['message']
            : response.reasonPhrase ?? 'Erro desconhecido';

        AppLogger.I()
            .error('URL $method Requisition', message, StackTrace.current);

        ShowToaster.toasterInfo(message: message);

        throw Exception('Erro no $method: ${response.statusCode}, $message');
      } else {
        final message = decodedBody is Map && decodedBody.containsKey('message')
            ? decodedBody['message']
            : response.reasonPhrase ?? 'Erro interno do servidor';

        AppLogger.I()
            .error('URL $method Requisition', message, StackTrace.current);

        CustomDialogs.showInformationDialog(
          content: 'dialog_500'.tr,
          onCancel: () => Get.back(),
        );

        throw Exception('Erro no $method: ${response.statusCode}, $message');
      }
    } catch (e, s) {
      AppLogger.I().error('URL $method Requisition', e, s);
      rethrow;
    }
  }
}
