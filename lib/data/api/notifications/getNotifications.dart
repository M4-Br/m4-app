import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';

Future<Map<String, dynamic>> getNotifications() async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');
  String codeLang = await SharedPreferencesFunctions.getString(key: 'codeLang');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    'Accept-Language': codeLang
  };

  final response = await http.get(
      Uri.parse('${ApiUrls.baseUrl}/notifications?per_page=50'),
      headers: headers);

  try {
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return jsonMap;
    } else {
      final jsonMap = json.decode(response.body);
      return jsonMap;
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
