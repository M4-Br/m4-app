import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getMembers(String id) async {
  try {
    String token = await SharedPreferencesFunctions.getString(key: 'token');

    final headers = {
      'Authorization': 'Bearer $token',
      'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
      'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    };

    final response = await http.get(
      Uri.parse('${ApiUrls.baseUrl}/group_accounts/$id/invites?per_page=25'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return responseBody;
    } else {
      throw Exception('Erro ao obter membros: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Erro geral ao obter membros: $e');
  }
}