import 'dart:convert';

import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_miban4/data/api/url/url_api.dart';

Future<Map> getTerms() async {

  String codeLang = await SharedPreferencesFunctions.getString(key: 'codeLang');

  final headers = {
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    'Accept-Language': codeLang
  };

  try {
    final url = Uri.parse("${ApiUrls.baseUrl}/app/terms");
    final response = await http.get(url, headers: headers);
    final jsonMap = json.decode(response.body);
    return jsonMap;
  } catch (e) {
    throw Exception(e.toString());
  }
}