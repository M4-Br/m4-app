import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/qrCode/decodeQRCode.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<DecodeQRCode> decodeCode(String content) async {

  String token = await SharedPreferencesFunctions.getString(key: 'token');

    final headers = {
      'Authorization': 'Bearer $token',
      'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
      'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final url1 = Uri.parse('${ApiUrls.baseUrl}/pix/code/decode');
    final response = await http.post(
      url1,
      headers: headers,
      body: json.encode({'content': content}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = json.decode(response.body);
      var decodeQRCode = DecodeQRCode.fromJson(responseData);

      return decodeQRCode;
    } else {
      final jsonMap = json.decode(response.body);
      final errorMessage = jsonMap['message'];
      Get.snackbar('Message', errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(8));
      throw Exception('Erro: ${response.statusCode}');
    }
}