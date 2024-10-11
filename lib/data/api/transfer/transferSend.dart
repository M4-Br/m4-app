import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/transaction/transaction.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/components/dialog/modal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Transaction> transactionSend(BuildContext context, int amount, String password,
    String username, String document) async {

  String token = await SharedPreferencesFunctions.getString(key: 'token');

  var url = Uri.parse('${ApiUrls.baseUrl}/transactions/p2p');

  var headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    'Content-Type': 'application/json; charset=UTF-8'
  };

  var body = {
    'amount': amount,
    'password': password,
    'username': username,
    'document': document
  };

  var response =
      await http.post(url, headers: headers, body: json.encode(body));

  if (response.statusCode == 200) {
    var responseData = json.decode(response.body);
    return Transaction.fromJson(responseData);
  } else {
    var responseError = json.decode(response.body);
    String error = responseError['error_message'];
    displayBottomSheet(context, response, error);
    return responseError;
  }
}
