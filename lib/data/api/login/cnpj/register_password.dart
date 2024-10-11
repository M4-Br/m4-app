import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


Future<Map<String, dynamic>> registerPassword(String password, String newPassword) async {

  String document = await SharedPreferencesFunctions.getString(key: 'document');
  String token = await SharedPreferencesFunctions.getString(key: 'token');

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final body = jsonEncode({
    "document": document,
    "password": password,
    "confirm_password": newPassword,
  });
  
  final response = await http.put(Uri.parse('${ApiUrls.baseUrl}/v2/account/forgot_password'), headers: headers, body: body);

  if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
    final jsonMap = json.decode(response.body);
    return jsonMap;
  } else {
    final jsonMap = json.decode(response.body);
    final errorMessage = jsonMap['message'] ?? jsonMap['message_error'];
    Get.snackbar('Erro ${response.statusCode}', errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.white,
        icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
        padding: const EdgeInsets.all(8));
    return jsonMap;
  }
}