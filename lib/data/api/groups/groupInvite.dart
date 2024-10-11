import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';

Future<Map<String, dynamic>> sendGroupInvite(List<String> ids) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');
  String id = await SharedPreferencesFunctions.getString(key: 'groupId');
  String userID = await SharedPreferencesFunctions.getString(key: 'userID');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    'Content-Type': 'application/json'
  };

  final body = jsonEncode({"users": ids});

  final response = await http.post(
      Uri.parse("${ApiUrls.baseUrl}/group_accounts/$id/many_invites"),
      headers: headers,
      body: body);

  try {
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonMap = json.decode(response.body);
      return jsonMap;
    } else {
      final jsonMap = json.decode(response.body);
      final jsonError = jsonMap['message'] ?? jsonMap['error_message'];
      Get.snackbar('MENSAGEM', jsonError,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(8));
      return jsonMap;
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
