import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/payment/payment_link_entity.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<PaymentLinkEntity> createPaymentLink(String amount) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  var body = {"amount": amount};

  try {
    final url = Uri.parse('${ApiUrls.baseUrl}/transactions/link/create');

    var response = await http.post(url, headers: headers, body: body);

    final jsonMap = json.decode(response.body);

    if (response.statusCode == 200) {
      if (jsonMap.containsKey('message')) {
        Get.snackbar('Mensagem', jsonMap['message'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 5),
            icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(8));
        throw Exception('Erro: ${jsonMap['message']}');
      } else {
        final payment = PaymentLinkEntity.fromJson(jsonMap);
        return payment;
      }
    } else {
      Get.snackbar('Mensagem', jsonMap['message'].toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(8));
      throw Exception('Erro: ${jsonMap['message']}');
    }
  } catch (e) {
    throw Exception('Erro: ${e.toString()}');
  }
}