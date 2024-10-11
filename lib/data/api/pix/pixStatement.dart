import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/pix/pixStatement.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<PixStatementModel> fetchPixStatement(
    String startDate, String endDate) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    'Content-Type': 'application/json',
  };

  final url = Uri.parse(
      '${ApiUrls.baseUrl}/pix/transfers?startDate=$startDate&endDate=$endDate');
  final response = await http.get(
    url,
    headers: headers,
  );

  try {
    if (response.statusCode == 202 || response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final statement = PixStatementModel.fromJson(jsonData);
      return statement;
    } else {
      throw Exception(
          'Erro na chamada da API: ${response.statusCode.toString()}, ${response.reasonPhrase}');
    }
  } catch (e) {
    Get.snackbar('Mensagem', e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(8));
    throw Exception(e.toString());
  }
}
