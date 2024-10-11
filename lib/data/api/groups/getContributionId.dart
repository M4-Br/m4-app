import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/groups/contributionID.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';

Future<ContributionID> getContributionId(String id) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');
  String code = await SharedPreferencesFunctions.getString(key: 'codeLang');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final response = await http
      .get(Uri.parse('${ApiUrls.baseUrl}/transactions/$id'), headers: headers);

  try {
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      final contribution = ContributionID.fromJson(jsonMap);
      return contribution;
    } else {
      // Se ocorrer um erro, você pode lançar uma exceção
      throw Exception(
          'Erro ao obter dados da contribuição: ${response.statusCode}');
    }
  } catch (e) {
    Get.snackbar(code == 'pt' ? "Mensagem" : "Message", e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(8));
    throw Exception('Erro ao processar resposta: $e');
  }
}
