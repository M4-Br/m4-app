
import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/services/services_model.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<ServicesModel>? fetchServices() async {

  String token = await SharedPreferencesFunctions.getString(key: 'token');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final url = Uri.parse('${ApiUrls.baseUrl}/service');

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
    print(jsonResponse);
    return ServicesModel.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load services');
  }

}