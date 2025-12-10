import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/TED/model/transfer_voucher_response.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferSuccessController extends BaseController {
  late TransferVoucher voucher;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;

    if (args != null && args is TransferVoucher) {
      voucher = args;
    } else {
      _handleError();
    }
  }

  void _handleError() {
    AppLogger.I().error('Transfer Success', 'Invalid Args: ${Get.arguments}',
        StackTrace.current);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowToaster.toasterInfo(
          message: 'Erro ao carregar dados da transferência');
      Get.offAllNamed(AppRoutes.homeView);
    });
  }

  String get receiverName {
    return voucher.receiver?.receiverFullName ?? 'Desconhecido';
  }

  String get receiverDocFormatted {
    final doc = voucher.receiver?.receiverDocument ?? '';
    return _formatDocument(doc);
  }

  String get bankName {
    return voucher.receiver?.receiverBank ?? 'Banco';
  }

  String _formatDocument(String doc) {
    if (doc.isEmpty) return '';
    if (doc.length >= 11) {
      return '${doc.substring(0, 3)}.${doc.substring(3, 6)}.${doc.substring(6, 9)}-${doc.substring(9)}';
    }
    return doc;
  }

  void goToHome() {
    Get.until((route) => route.settings.name == AppRoutes.homeView);
  }

  void goToNewTransfer() {
    Get.until((route) => route.settings.name == AppRoutes.transfer);
  }

  void goToVoucherDetails() {
    Get.toNamed(AppRoutes.transferVoucher, arguments: voucher);

    AppLogger.I().info('Opening transfer voucher');
  }
}
