// lib/features/accounting/controller/accounting_payment_controller.dart

import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';

class AccountingPaymentController extends BaseController {
  final paymentData = {
    'cnpj': '12.345.678/0001-00', // [cite: 76]
    'totalValue': 250.00, // [cite: 77]
    'period': 'Setembro/2025', // [cite: 78]
    'dueDate': '20/10/2025', // [cite: 79]
    'barcode': '12345678901 12345678901', //
  }.obs;

  void copyBarcode() {
    final code = paymentData['barcode'] as String;
    Clipboard.setData(ClipboardData(text: code));
    ShowToaster.toasterInfo(message: 'Código de barras copiado!');
  }

  Future<void> confirmPayment() async {
    isLoading.value = true;
    try {
      // Simula chamada de API
      await Future.delayed(const Duration(seconds: 2));

      ShowToaster.toasterInfo(message: 'Pagamento realizado com sucesso!');
      Get.back(); // Volta para a Home
      // Aqui você poderia atualizar o status na Home para "Pago"
    } catch (e) {
      ShowToaster.toasterInfo(message: 'Erro ao processar pagamento');
    } finally {
      isLoading.value = false;
    }
  }
}
