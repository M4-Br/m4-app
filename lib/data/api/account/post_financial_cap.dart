import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> postFinancialCap(
    String groupID,
    String income,
    String peopleFamily,
    String house,
    String transport,
    String houseCost,
    String transportCost,
    String utilitiesCost,
    String otherCosts) async {
  final headers = {
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final body = {
    "user_id": 'id',
    "group_account_id": groupID,
    "income_family": income.toString(),
    "people_family": peopleFamily,
    "house": house,
    "transport": transport,
    "house_cost": houseCost,
    "transport_cost": transportCost,
    "utilities_cost": utilitiesCost,
    "other_cost": otherCosts
  };

  final response = await http.post(
      Uri.parse('${ApiUrls.baseUrl}/payment_capacity'),
      headers: headers,
      body: body);

  if (response.statusCode == 200 ||
      response.body == 201 ||
      response.body == 202) {
    final jsonMap = json.decode(response.body);
    return jsonMap;
  } else {
    final jsonMap = json.decode(response.body);
    final jsonError = jsonMap['message'] ?? jsonMap['error_message'];

    return jsonMap;
  }
}
