import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/barcode/decodeBarcode.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<PaymentData> decodeBarcode(String barcode) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');
  String code = await SharedPreferencesFunctions.getString(key: 'codeLang');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  try {
    final url = Uri.parse('${ApiUrls.baseUrl}/payment/validate/$barcode');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonMap = json.decode(response.body);
      final payment = PaymentData.fromJson(jsonMap);
      return payment;
    } else {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      Get.snackbar(code == 'pt' ? "Mensagem" : "Message", responseBody['message'],
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(8));
      throw Exception(
          'Falha ao carregar dados da API, ${response.body}, ${response.statusCode}, ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
