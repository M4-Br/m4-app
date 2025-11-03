import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/components/dialog/modal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> sendPixTransfer(
  String amount,
  String description,
  String id,
  String password,
  String idText,
  String accountNumber,
  String accountType,
  String branchNumber,
  String type,
  String document,
  String ispb,
  String name,
  String key,
  int transferType,
  String date,
) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');

  var url = Uri.parse('${ApiUrls.baseUrl}/pix/transfers');

  var headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    'Content-Type': 'application/json; charset=UTF-8'
  };

  var body = jsonEncode({
    "amount": amount,
    "description": description,
    "id_end_to_end": id,
    "password": password,
    "id_tx": idText,
    "transfer_type": transferType,
    "startDate": date,
    "endDate": date,
    "payee": {
      "bank_account_number": accountNumber,
      "bank_account_type": accountType,
      "bank_branch_number": branchNumber,
      "beneficiary_type": type,
      "document": document,
      "ispb": ispb,
      "name": name,
      "key": key
    }
  });

  var response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200 || response.statusCode == 201) {
    final responseData = json.decode(response.body);
    return responseData;
  } else {
    final errorMap = json.decode(response.body);
    final errorMessage = errorMap['message'];
    Get.snackbar('Erro ${response.statusCode}', errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(8));
    return errorMap;
  }
}
