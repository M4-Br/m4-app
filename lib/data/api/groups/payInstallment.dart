import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/groups/paymentInstallment.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/config/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<PayInstallment> payInstallment(String id) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final response = await http.put(
      Uri.parse('${ApiUrls.baseUrl}/transactions/$id/group_account_payment'),
      headers: headers);

  try {
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      final payment = PayInstallment.fromJson(jsonMap);
      return payment;
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
    throw Exception(e.toString());
  }
}
