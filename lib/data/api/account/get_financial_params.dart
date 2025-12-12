import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getFinancialParams() async {
  final headers = {
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final response = await http.get(
      Uri.parse('${ApiUrls.baseUrl}/payment_capacity/params'),
      headers: headers);

  if (response.statusCode == 200) {
    final jsonMap = json.decode(response.body);
    return jsonMap;
  } else {
    final jsonMap = json.decode(response.body);
    final jsonError = jsonMap['message'] ?? jsonMap['error_message'];

    return jsonMap;
  }
}
