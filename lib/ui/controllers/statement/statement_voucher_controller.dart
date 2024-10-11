import 'package:app_flutter_miban4/data/api/statement/statment_voucher.dart';
import 'package:app_flutter_miban4/data/model/statement/statementVoucherModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StatementVoucherController extends GetxController {
  var isLoading = false.obs;
  Rx<StatementVoucher> voucher = StatementVoucher().obs;

  Future<void> getVoucher(String id) async {
    isLoading(true);

    try {
      StatementVoucher response = await getStatementVoucher(id);

      if (response.success == true) {
        voucher.value = response;
        isLoading(false);
      }
    } catch (error) {
      isLoading(false);
      Get.snackbar('Erro 500', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(8));
    } finally {
      isLoading(false);
    }
  }
}