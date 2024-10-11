import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_miban4/data/model/bank/bank_entity.dart';

Future<List<Bank>> getBanks() async {
  final headers = {
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final response = await http.get(Uri.parse('${ApiUrls.baseUrl}/banks_list'), headers: headers);

  try {
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      final banks = jsonList.map((json) => Bank.fromJson(json)).toList();
      return banks;
    } else {
      final jsonMap = json.decode(response.body);
      final errorMessage = jsonMap['error'] ?? jsonMap['error_message'];
      throw Exception(errorMessage);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
