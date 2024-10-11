import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getDocumentVerify(
    String document, int page) async {
  final url = Uri.parse('${ApiUrls.baseUrl}/v2/individual/$document');
  final response = await http.get(url);

  if (response.statusCode == 200 || response.statusCode == 201) {
    final jsonMap = json.decode(response.body);

    await SharedPreferencesFunctions.saveString(
        key: 'id', value: jsonMap['id'].toString());
    await SharedPreferencesFunctions.saveString(
        key: 'document', value: document);

    if (jsonMap['user'] != null) {
      await SharedPreferencesFunctions.saveString(
          key: 'userID', value: jsonMap['user']['id'].toString());
    }

    return jsonMap;
  } else {
    final Map<dynamic, dynamic> errorResponse = json.decode(response.body);
    final String errorMessage = errorResponse["error_message"];
    page == 0
        ? Get.snackbar('Mensagem', errorMessage,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 5),
            icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(8))
        : null;
    throw Exception(
        "$errorMessage, ${response.reasonPhrase.toString()}, ${response.body}");
  }
}
