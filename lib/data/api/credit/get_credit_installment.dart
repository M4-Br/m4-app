import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/groups/contributionID.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';

Future<ContributionID> getCreditInstallment(
    String id, BuildContext context) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final url = Uri.parse('${ApiUrls.baseUrl}/transactions/$id/mutual_payment');

  try {
    final response = await http.put(url, headers: headers).timeout(
      const Duration(seconds: 18),
      onTimeout: () {
        Get.defaultDialog(
            title: "Servidor indisponível",
            content: Column(
              children: [
                const Text(
                  'Tente novamente mais tarde.',
                  style: TextStyle(color: Colors.black),
                ),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: secondaryColor),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ));
        return http.Response('{"message": "Request timed out"}', 408);
      },
    );

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      final contribution = ContributionID.fromJson(jsonMap);
      return contribution;
    } else {
      final jsonMap = json.decode(response.body);
      Get.defaultDialog(
          title: 'dialogErro'.tr.toUpperCase(),
          content: Column(
            children: [
              Text(jsonMap['message'], textAlign: TextAlign.center,),
              ElevatedButton(
                onPressed: () => Get.back(),
                style:
                ElevatedButton.styleFrom(backgroundColor: secondaryColor),
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ));
    return jsonMap;
    }
  } catch (e) {
    throw Exception('Erro na requisição: $e');
  }
}
