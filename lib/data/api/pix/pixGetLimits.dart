import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/pix/pixMyLimits.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<PixLimits> pixGetLimits() async {

  String token = await SharedPreferencesFunctions.getString(key: 'token');
  String codeLang = await SharedPreferencesFunctions.getString(key: 'codeLang');

  try {
    final headers = {
      'Authorization': 'Bearer $token',
      'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
      'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
      'Accept-Language': codeLang
    };

    final url1 = Uri.parse('${ApiUrls.baseUrl}/pix/limits');
    final response = await http.get(
      url1,
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      final pixLimits = PixLimits.fromJson(jsonData);

      return pixLimits;
    } else {
      final jsonMap = json.decode(response.body);
      final errorMessage = jsonMap['message'];
      Get.snackbar('Erro ${response.statusCode}', errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(8));
      throw Exception(
          'Erro na chamada da API: ${response.statusCode.toString()}');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}