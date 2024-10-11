import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/transaction/transfer.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchUser(String document) async {

  String token = await SharedPreferencesFunctions.getString(key: 'token');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final url = Uri.parse('${ApiUrls.baseUrl}/account/document/$document');
  final response = await http.get(url, headers: headers);

  try {
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonMap = json.decode(response.body);
      return jsonMap;
    } else {
      throw Exception('Falha ao carregar dados da API');
    }
  } catch(e) {
    throw Exception(e.toString());
  }

}