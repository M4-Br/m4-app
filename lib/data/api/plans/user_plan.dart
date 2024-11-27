import 'dart:convert';

import 'package:app_flutter_miban4/data/model/plans/plans_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';

Future<UserPlanModel> getUserPlans() async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final url = Uri.parse('${ApiUrls.baseUrl}/plans');

  final response = await http.get(url, headers: headers);

  try {
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final jsonResponse = json.decode(response.body) as List;
      final plans = jsonResponse.map((item) => UserPlanModel.fromJson(item)).toList();
      await SharedPreferencesFunctions.saveString(key: 'userPlanUUID', value: plans[0].items[0].id);
      return plans.first;
    } else {
      final jsonResponse = json.decode(response.body);
      final plans = UserPlanModel.fromJson(jsonResponse);
      return plans;
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}