import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixCopyPaste.dart';
import 'package:get/get.dart';

class PixHomeController extends BaseController {
  final BalanceRx balance;
  PixHomeController({required this.balance});

  var isVisible = false.obs;

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  void goToPixKeyManager() {
    Get.toNamed(AppRoutes.pixKeyManager);
    AppLogger.I().info('Going to Pix Key Manager');
  }

  void goToLimits() {
    Get.toNamed(AppRoutes.pixLimits);
    AppLogger.I().info('Going to Pix Limits');
  }

  void goToReceivePix() {
    Get.toNamed(AppRoutes.pixReceive);
    AppLogger.I().info('Going to Pix Receive');
  }

  void goToPixWithKey() {
    Get.toNamed(AppRoutes.pixWithKey);
    AppLogger.I().info('Going to Pix With Key');
  }

  void goToCopyPaste() {
    final currentBalance = balance.balance.value;

    Get.to(
      () => PixCopyPaste(balance: currentBalance),
      transition: Transition.rightToLeft,
    );
  }
}
