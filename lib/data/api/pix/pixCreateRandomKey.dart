import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/pix/pixCreateKey.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<PixCreateKey> createRandomKey() async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final url = Uri.parse('${ApiUrls.baseUrl}/pix/dict');
  final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(<String, dynamic>{
      'key_type': 'evp',
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 202) {
    final jsonData = json.decode(response.body);
    final pixKeyCreated = PixCreateKey.fromJson(jsonData);

    return pixKeyCreated;
  } else {
    final jsonErrorMap = json.decode(response.body);
    final errorMessage = jsonErrorMap['message'];
    Get.snackbar('Erro ${response.statusCode}', errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.white,
        icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
        padding: const EdgeInsets.all(8));
    throw Exception(
        'Erro na chamada da API: ${response.statusCode.toString()}');
  }
}
