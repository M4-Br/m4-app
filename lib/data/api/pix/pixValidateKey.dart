import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/pix/pixValidateKey.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/components/dialog/modal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<ValidateKey> validateKey(String key) async {

  String token = await SharedPreferencesFunctions.getString(key: 'token');

  var headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    'Content-Type': 'application/json'
  };

  final response = await http.get(Uri.parse("${ApiUrls.baseUrl}/pix/dict/validate/$key"), headers: headers);

  if (response.statusCode == 200 || response.statusCode == 202) {
    final jsonMap = json.decode(response.body);
    final key = ValidateKey.fromJson(jsonMap);
    return key;
  } else {
    final jsonMap = json.decode(response.body);
    final errorMessage = jsonMap['message'];
    Get.snackbar('Erro ${response.statusCode}', errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(8));
    return jsonMap;
  }
}