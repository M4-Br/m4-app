import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> createMutualParams(
    int amount, String installment, String priority, bool billing) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');
  String id = await SharedPreferencesFunctions.getString(key: 'groupId');
  String code = await SharedPreferencesFunctions.getString(key: 'codeLang');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final body = {
    "amount_by_period": amount.toString(),
    "installment": installment,
    "priority": priority,
    "billing": billing.toString()
  };
  
  final response = await http.post(Uri.parse('${ApiUrls.baseUrl}/group_accounts/$id/mutual'), headers: headers, body: body);

  try {
    if (response.statusCode == 201) {
      final jsonMap = json.decode(response.body);
      return jsonMap;
    } else {
      final jsonMap = json.decode(response.body);
      Get.snackbar(code == 'pt' ? "Mensagem" : "Message", jsonMap['message'] ?? jsonMap['error_message'],
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.white,
          icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
          padding: const EdgeInsets.all(8));
      return jsonMap;
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
