import 'dart:convert';

import 'package:app_flutter_miban4/core/config/consts/app_header.dart';
import 'package:app_flutter_miban4/core/config/consts/app_url.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:http/http.dart' as http;

class ApiConnection {
  ApiConnection();

  Future<T> post<T>({
    required http.Client client,
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? body,
  }) async {
    final response = await client.post(
      Uri.parse('${UrlConst.urlBase}$endpoint'),
      headers: AppHeader().headers,
      body: json.encode(body),
    );

    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = json.decode(response.body);
        return fromJson(jsonResponse);
      } else {
        throw Exception('Erro no post genérico');
      }
    } catch (e, s) {
      AppLogger.I().error('URL Post Requisition', e, s);
      rethrow;
    }
  }

  Future<T> get<T>({
    required http.Client client,
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? body,
  }) async {
    final response = await client.post(
      Uri.parse('${UrlConst.urlBase}$endpoint'),
      headers: AppHeader().headers,
    );

    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = json.decode(response.body);
        return fromJson(jsonResponse);
      } else {
        throw Exception('Erro no get genérico');
      }
    } catch (e, s) {
      AppLogger.I().error('URL Get Requisition', e, s);
      rethrow;
    }
  }
}
