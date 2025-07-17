import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/components/dialog/modal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> transferOtherBank(
    {required BuildContext context,
    required String amount,
    required String password,
    required String document,
    required String name,
    required String bankCode,
    required String agency,
    required String agencyDigit,
    required String accountNumber,
    required String accountDigit,
    required String accountType}) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');

  var url = Uri.parse('${ApiUrls.baseUrl}/transactions/ted');

  var headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  var body = {
    "amount": amount,
    "password": password,
    "document": document,
    "name": name,
    "bank_code": bankCode,
    "agency": agency,
    "agency_digit": agencyDigit,
    "account_number": accountNumber,
    "account_digit": accountDigit,
    "account_type": accountType
  };

  var response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    return responseData;
  } else {
    final responseError = json.decode(response.body);
    String error = responseError['message'];
    displayBottomSheet(context, response, error);
    return responseError;
  }
}
