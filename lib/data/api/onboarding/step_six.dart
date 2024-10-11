import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> createStepSix(
    String username,
    String motherName,
    String gender,
    String birthDate,
    String maritalStatus,
    String nationality,
    String documentNumber,
    String documentState,
    String issuanceDate,
    bool pep,
    String pepSince) async {

  String id = await SharedPreferencesFunctions.getString(key: 'id');

  final headers = {
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    'Content-Type': 'application/json'
  };

  Map<String, dynamic> body = {
    "individual_id": id,
    "document_name": username,
    "document_state": documentState,
    "document_number": documentNumber,
    "mother_name": motherName,
    "gender": gender,
    "birth_date": birthDate,
    "marital_status": maritalStatus,
    "nationality": nationality,
    "nationality_state": documentState,
    "issuance_date": issuanceDate,
    "pep": pep,
    "pep_since": pepSince
  };

  try {
    final url = Uri.parse(
        "${ApiUrls.baseUrl}/v2/register/individual/step5");
    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));

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
          "${response.statusCode}, ${response.reasonPhrase}, ${response.body}, ${response.contentLength}");
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
