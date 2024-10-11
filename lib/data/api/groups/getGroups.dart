import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/groups/groupModel.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/components/dialog/modal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Group>> getGroups(BuildContext context) async {
  try {
    String token = await SharedPreferencesFunctions.getString(key: 'token');
    String code = await SharedPreferencesFunctions.getString(key: 'codeLang');

    final headers = {
      'Authorization': 'Bearer $token',
      'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
      'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    };

    final response = await http.get(
      Uri.parse('${ApiUrls.baseUrl}/group_accounts'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<Group> groups = jsonList.map((json) => Group.fromJson(json)).toList();
      return groups;
    } else {
      final jsonError = json.decode(response.body);
      final jsonErrorMessage = jsonError['error_message'];
      displayBottomSheet(context, response, jsonErrorMessage);
      throw Exception("Error: $jsonErrorMessage");
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}