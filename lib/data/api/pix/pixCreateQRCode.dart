import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/pix/pixReceiveQRCode.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<CreatePIXQrCode> createPIXQrCode(String key, String? amount, String? title, String? description) async {

  String token = await SharedPreferencesFunctions.getString(key: 'token');

  try {
    if (key == null || amount == null || description == null) {
      throw Exception('One or more required parameters are null.');
    }

    final headers = {
      'Authorization': 'Bearer $token',
      'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
      'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final url = Uri.parse('${ApiUrls.baseUrl}/pix/code/static');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        'key': key,
        'amount': amount,
        'title': title,
        'description': description,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202 || response.statusCode == 203) {
      final jsonData = json.decode(response.body);
      final createPIXQrCode = CreatePIXQrCode.fromJson(jsonData);

      return createPIXQrCode;
    } else {
      final jsonMap = json.decode(response.body);
      final errorMessage = jsonMap['message'];
      Get.snackbar('Erro ${response.statusCode}', errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(8));
      throw Exception('Failed to create PIX QR code.');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
