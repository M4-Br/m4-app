import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/controller/tracking_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:get/get.dart';

class DigitalAccountController extends BaseController {
  final BalanceRx balance;
  DigitalAccountController(this.balance);
  var isBalanceVisible = true.obs;

  void toggleBalanceVisibility() {
    isBalanceVisible.value = !isBalanceVisible.value;
  }

  // --- MAPEAMENTO DE IDs PARA O BACKEND ---
  // Continuamos a contagem a partir do 10 (A Home foi até o 9)
  int _getTrackingId(String option) {
    switch (option) {
      case 'statement':
        return 10; // Extrato de Conta
      case 'transfer':
        return 11; // Transferências
      case 'barcode':
        return 12; // Pagamento de Boletos
      case 'investments':
        return 13; // Investimentos
      case 'insurance':
        return 14; // Seguros
      case 'pix':
        return 15; // Pix (Caso decida trackear, já tem ID)
      default:
        return 0; // Não rastrear
    }
  }

  void onOptionTap(String option) {
    // --- 1. REGISTRA O CLIQUE LOCALMENTE ---
    int trackingId = _getTrackingId(option);
    if (trackingId != 0) {
      TrackerController.to.trackClick(trackingId);
      AppLogger.I().info('Tracked click for $option (ID: $trackingId)');
    }

    // --- 2. NAVEGAÇÃO NORMAL DO APP ---
    switch (option) {
      case 'statement':
        Get.toNamed(AppRoutes.statement);
        AppLogger.I().info('Going to Statement Page');
        break;
      case 'pix':
        Get.toNamed(AppRoutes.pixHome);
        AppLogger.I().info('Going to Pix Home');
        break;
      case 'transfer':
        Get.toNamed(AppRoutes.transfer);
        AppLogger.I().info('Going to Transfer Page');
        break;
      case 'barcode':
        Get.toNamed(AppRoutes.barcode);
        AppLogger.I().info('Going to Barcode Payment');
        break;
      case 'investments':
        AppLogger.I().info('Going to Investments Page');
        ShowToaster.toasterInfo(message: 'Investimentos em breve.');
        break;
      case 'insurance':
        AppLogger.I().info('Going to Insurance Page');
        ShowToaster.toasterInfo(message: 'Seguros em breve.');
        break;
      default:
        AppLogger.I().info('Option $option not mapped');
    }
  }
}
