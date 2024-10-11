import 'dart:convert';

import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/groups/contributionID.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<ContributionID> getCreditInstallment(String id, BuildContext context) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');
  String code = await SharedPreferencesFunctions.getString(key: 'codeLang');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final url = Uri.parse('${ApiUrls.baseUrl}/transactions/$id/mutual_payment');
  final response = await http.put(url, headers: headers);

  try {
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      final contribution = ContributionID.fromJson(jsonMap);
      return contribution;
    } else {
      final jsonMap = json.decode(response.body);
      final message = jsonMap['message'];
      Get.dialog(
        AlertDialog(
          title: Text(AppLocalizations.of(context)!.dialog_error, textAlign: TextAlign.center,),
          content: Text(
              message),
          actions: [
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45)),
                    backgroundColor: secondaryColor),
                onPressed: () {
                  Get.back(); // Fechar o diálogo
                  Get.back();
                  Get.back();
                },
                child: Text(
                  AppLocalizations.of(context)!
                      .buttonDialogClose
                      .toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      );
      throw Exception(
          'Erro ao obter dados da contribuição: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
