
import 'package:app_flutter_miban4/data/api/statement/statementAuth.dart';
import 'package:app_flutter_miban4/data/model/statement/statementModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StatementController extends GetxController {
  var isLoading = false.obs;
  List<dynamic> statements = [].obs;

  Future<void> getStatements(String startDate, String endDate, String accountId) async {
    isLoading(true);

    try {
      StatementModel statementData = await fetchStatement(startDate, endDate, accountId);
      statements = statementData.statements!;
    } catch (error) {
      isLoading(false);
      Get.snackbar('Erro', 'Falha ao consultar extrato: $error',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.white,
          icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
          padding: const EdgeInsets.all(8));
    } finally {
      isLoading(false);
    }
  }
}