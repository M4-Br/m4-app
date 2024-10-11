import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';

Future<bool> creditVote(String id, String vote) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');
  String code = await SharedPreferencesFunctions.getString(key: 'codeLang');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };
  
  final response = await http.put(Uri.parse('${ApiUrls.baseUrl}/mutual_user_votes/$id/$vote'), headers: headers);

  try {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      Get.snackbar(code == 'pt' ? "Mensagem" : "Message", responseBody['message'],
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(8));
      return false;
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}