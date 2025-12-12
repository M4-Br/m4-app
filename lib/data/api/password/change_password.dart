import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> changePassword(
    String password, String confirm) async {
  final headers = {
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final body = {'password': password, 'confirm_password': confirm};

  final response = await http.put(
      Uri.parse(
          '${ApiUrls.baseUrl}/account/forgot_password?token=token'), //PASSAR TOKEN AQUI
      headers: headers);

  if (response.statusCode == 200) {
    final jsonMap = json.decode(response.body);
    return jsonMap;
  } else {
    throw Exception('errorMessage');
  }
}
