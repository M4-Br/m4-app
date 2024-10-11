import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';

Future<Map<String, dynamic>> changePassword(
    String password, String confirm) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');
  String codeLang = await SharedPreferencesFunctions.getString(key: 'codeLang');

  final headers = {
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final body = {"password": password, "confirm_password": confirm};

  final response = await http.put(
      Uri.parse("${ApiUrls.baseUrl}/account/forgot_password?token=$token"),
      headers: headers);

  if (response.statusCode == 200) {
    final jsonMap = json.decode(response.body);
    return jsonMap;
  } else {
    final Map<String, dynamic> errorResponse = json.decode(response.body);
    final String errorMessage = errorResponse["message"] ?? ["message_error"];
    Get.snackbar(codeLang == 'pt' ? "Mensagem" : "Message", errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.white,
        icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
        padding: const EdgeInsets.all(8));
    throw Exception(errorMessage);
  }
}
