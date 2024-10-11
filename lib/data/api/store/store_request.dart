import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/store/store_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';

Future<List<Merchant>> merchantRequest() async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');
  String lang = await SharedPreferencesFunctions.getString(key: 'codeLang');

  var url = Uri.parse('${ApiUrls.baseUrl}/voucher/merchants');

  var headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode >= 200 && response.statusCode <= 299) {
    final jsonResponse = json.decode(response.body);

    final List<dynamic> jsonList = jsonResponse['merchants'];
    var merchantList = jsonList.map((json) => Merchant.fromJson(json)).toList();

    return merchantList;
  } else if (response.statusCode >= 400 && response.statusCode <= 499) {
    final jsonMap = json.decode(response.body);
    final errorMessage = jsonMap['message'];
    Get.snackbar(lang == 'pt' ? "Mensagem" : "Message", errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(8));
    throw Exception('Erro: ${response.statusCode}');
  } else {
    Get.snackbar(lang == 'pt' ? "Mensagem" : "Message", 'Verifique sua conexão',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(8));
    throw Exception('Erro: ${response.statusCode}');
  }
}

