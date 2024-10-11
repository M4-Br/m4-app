import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> createStepFour(
  String postalCode,
  String type,
  String street,
  String number,
  String neighborhood,
  String complement,
  String state,
  String city,
  String country,
) async {

  String id = await SharedPreferencesFunctions.getString(key: 'id');

  final headers = {
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final body = {
    "individual_id": id,
    "postal_code": postalCode,
    "address_type_id": type,
    "street": street,
    "number": number,
    "neighborhood": neighborhood,
    "complement": complement,
    "state": state,
    "city": city,
    "country": country
  };

    final url = Uri.parse(
        "${ApiUrls.baseUrl}/v2/register/individual/step3");
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonMap = json.decode(response.body);

      return jsonMap;
    } else {
      final jsonMap = json.decode(response.body);
      final errorMessage = jsonMap['message'];
      Get.snackbar('Erro ${response.statusCode}', errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.white,
          icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
          padding: const EdgeInsets.all(8));
      throw Exception(
          "${response.statusCode}, ${response.reasonPhrase}, ${response.body}");
    }
}
