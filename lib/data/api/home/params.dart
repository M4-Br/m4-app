import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/params/params.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';

Params? globalParams;

Future<void> fetchAndStoreParams() async {
  try {
    String token = await SharedPreferencesFunctions.getString(key: 'token');

    final headers = {
      'Authorization': 'Bearer $token',
      'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
      'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
      'Content-Type': 'application/json'
    };

    final response = await http.get(
      Uri.parse("${ApiUrls.baseUrl}/group_accounts/params"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      globalParams = Params.fromJson(jsonMap);
    } else {
      // Handle error response here
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exceptions here
    print('Exception: $e');
  }
}

Params? getGlobalParams() {
  return globalParams;
}
