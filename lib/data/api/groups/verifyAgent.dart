import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> verifyAgent() async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    'Content-Type': 'application/json'
  };

  final response =
      await http.get(Uri.parse('${ApiUrls.baseUrl}/user'), headers: headers);

  if (response.statusCode == 200) {
    final jsonMap = json.decode(response.body);
    return jsonMap;
  } else {
    final jsonMap = json.decode(response.body);
    return jsonMap;
  }
}
