import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/statement/statementModel.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<StatementModel> fetchStatement(String startDate, String endDate, String accountId) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');

  var url = Uri.parse('${ApiUrls.baseUrl}/v2/statements?startDate=$startDate&endDate=$endDate&accountId=$accountId');

  var headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    'Content-Type': 'application/json'
  };

  var response = await http.get(url, headers: headers); // Use http.get

  try {
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var statement = StatementModel.fromJson(jsonData);
      return statement;
    } else {
      final jsonData = json.decode(response.body);
      final error = jsonData['message'];
      throw Exception('Erro na chamada da API: ${response.statusCode}, ${response.body}');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}