import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> createGroup(String name, bool membership) async {
  try {
    String token = await SharedPreferencesFunctions.getString(key: 'token');
    String code = await SharedPreferencesFunctions.getString(key: 'codeLang');

    final headers = {
      'Authorization': 'Bearer $token',
      'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
      'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
      'Content-Type': 'application/json'
    };

    final body = jsonEncode({"name": name, "agent_was_membership": membership});

    final response = await http.post(
        Uri.parse('${ApiUrls.baseUrl}/group_accounts'),
        headers: headers,
        body: body);

    if (response.statusCode == 201) {
      final jsonMap = json.decode(response.body);
      await SharedPreferencesFunctions.saveString(key: 'groupId', value: jsonMap['id'].toString());
      await SharedPreferencesFunctions.saveString(key: 'userID', value: jsonMap['user_id'].toString());
      return jsonMap;
    } else {
      final jsonMap = json.decode(response.body);
      return jsonMap;
    }
  } catch (e) {
    Get.snackbar('Error', e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(8));
    throw Exception(e.toString());
  }
}
