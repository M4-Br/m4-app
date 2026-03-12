import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:get/get.dart';

class DigitalAccountController extends BaseController {
  final BalanceRx balance;
  DigitalAccountController(this.balance);
  var isBalanceVisible = true.obs;

  void toggleBalanceVisibility() {
    isBalanceVisible.value = !isBalanceVisible.value;
  }

  void onOptionTap(String option) {
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
      default:
        AppLogger.I().info('Option $option not mapped');
    }
  }
}
