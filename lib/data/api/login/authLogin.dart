import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/userData/user.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<UserData> verifyLogin(String? document, String password) async {
  String code = await SharedPreferencesFunctions.getString(key: 'codeLang');

  final headers = {
    'Content-Type': 'application/json',
    'Accept-Language': code
  };


  final url = Uri.parse('${ApiUrls.baseUrl}/v3/auth');
  final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(<String, dynamic>{
      'document': document,
      'password': password,
      'is_android': true.toString(),
    }),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final user = UserData.fromJson(jsonResponse);
    return user;
  } else {
    final Map<String, dynamic> errorResponse = json.decode(response.body);
    final String errorMessage = errorResponse["message"] ?? ["message_error"];
    Get.snackbar(code == 'pt' ? "Mensagem" : "Message", errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.white,
        icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
        padding: const EdgeInsets.all(8));
    throw Exception(errorMessage);
  }
}
