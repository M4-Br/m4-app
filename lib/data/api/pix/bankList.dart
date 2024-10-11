
import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/pix/banks_model.dart';
import 'package:http/http.dart' as http;

Future<List<BankList>> getBanks() async {
  
  final headers = {
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };
  
  try {
    final response = await http.get(Uri.parse("${ApiUrls.baseUrl}/banks_list"), headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      final List<BankList> bankList = jsonList.map((jsonItem) => BankList.fromJson(jsonItem)).toList();
      return bankList;
    } else {
      throw Exception('${response.statusCode}, ${response.body}, ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}