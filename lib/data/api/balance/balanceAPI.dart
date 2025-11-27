import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

Future<Balance> getBalance() async {
  final box = GetStorage();

  String token = box.read('token');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  try {
    final url = Uri.parse('${ApiUrls.baseUrl}/account/balance');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      final balance = Balance.fromJson(jsonMap);

      return balance;
    } else {
      throw Exception(
          'Falha ao carregar dados da API, ${response.statusCode}, ${response.body}');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
