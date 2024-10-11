import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> acceptRejectGroup(String id, String type) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');
  String code = await SharedPreferencesFunctions.getString(key: 'codeLang');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    'Content-Type': 'application/json'
  };

  final response = await http
      .put(Uri.parse('${ApiUrls.baseUrl}/invites/$id/$type'), headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonMap = json.decode(response.body);
      return jsonMap;
    } else {
      final jsonErrorMap = json.decode(response.body);
      final errorMessage = jsonErrorMap['message'];
      Get.snackbar(code == 'pt' ? "Mensagem" : "Message", errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.white,
          icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
          padding: const EdgeInsets.all(8));
      throw Exception(
          'Erro na chamada da API: ${response.body.toString()}');
    }
}
