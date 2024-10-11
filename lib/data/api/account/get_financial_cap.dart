import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';

Future<Map<String, dynamic>> getFinancialCap() async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');
  String id = await SharedPreferencesFunctions.getString(key: 'userID');
  String code = await SharedPreferencesFunctions.getString(key: 'codeLang');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };
  
  final response = await http.get(Uri.parse('${ApiUrls.baseUrl}/payment_capacity/$id'), headers: headers);

  if (response.statusCode == 200) {
    final jsonMap = json.decode(response.body);
    return jsonMap;
  } else {
    final jsonMap = json.decode(response.body);
    final jsonError = jsonMap['message'] ?? jsonMap['error_message'];
    Get.snackbar(code == 'pt' ? "Mensagem" : "Message", jsonError,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(8));
    return jsonMap;
  }
}