import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/barcode/barcode_payment_model.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<BarcodeVoucher> payBarcode(BuildContext context, int amount,
    String password, String barcode, String date, String assignor) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');
  String code = await SharedPreferencesFunctions.getString(key: 'codeLang');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final body = {
    "amount": amount,
    "password": password,
    "bar_code": barcode,
    "due_date": date,
    "assignor": assignor
  };

  final response = await http.post(
      Uri.parse("${ApiUrls.baseUrl}/transactions/payment"),
      headers: headers,
      body: json.encode(body));

  try {
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      final voucher = BarcodeVoucher.fromJson(jsonMap);
      return voucher;
    } else {
      final jsonError = json.decode(response.body);
      final voucher = BarcodeVoucher.fromJson(jsonError);
      Get.snackbar(code == 'pt' ? "Mensagem" : "Message", jsonError['message'],
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(8));
      return voucher;
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
