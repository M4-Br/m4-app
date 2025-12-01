import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/features/paymentLink/repository/payment_link_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';

class PaymentLinkController extends BaseController {
  final moneyController = TextEditingController();
  final isButtonEnabled = false.obs;

  @override
  void onClose() {
    moneyController.dispose();
    super.onClose();
  }

  void onValueChanged(String value) {
    final double valueDouble = value.toCurrencyDouble();
    isButtonEnabled.value = valueDouble >= 10.0;
  }

  Future<void> createLink() async {
    if (!isButtonEnabled.value) return;
    await executeSafe(() async {
      final int amountInCents = moneyController.text.toCents();
      final amountValue = amountInCents.toString();

      final paymentLink =
          await PaymentLinkRepository().createLink(amount: amountValue);

      if (paymentLink.success == true) {
        Get.toNamed(AppRoutes.paymentLinkGenerated, arguments: paymentLink);
        AppLogger.I().info('Payment Link created');
      }
    }, message: 'Erro ao gerar link de pagamento');
  }
}
