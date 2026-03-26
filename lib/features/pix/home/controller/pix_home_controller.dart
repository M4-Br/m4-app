import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/controller/tracking_controller.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:get/get.dart';

class PixHomeController extends BaseController {
  final BalanceRx balance;
  PixHomeController({required this.balance});

  var isVisible = false.obs;

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  void _track(int id, String name) {
    TrackerController.to.trackClick(id);
    AppLogger.I().info('Tracked click for $name (ID: $id)');
  }

  void goToStatement() {
    _track(16, 'Extrato Pix');
    Get.toNamed(AppRoutes.pixStatement);
    AppLogger.I().info('Going to Pix Statement');
  }

  void goToPixKeyManager() {
    _track(17, 'Gerenciamento de Chaves');
    Get.toNamed(AppRoutes.pixKeyManager);
    AppLogger.I().info('Going to Pix Key Manager');
  }

  void goToLimits() {
    _track(18, 'Limites');
    Get.toNamed(AppRoutes.pixLimits);
    AppLogger.I().info('Going to Pix Limits');
  }

  void goToReceivePix() {
    _track(19, 'Receber Pix');
    Get.toNamed(AppRoutes.pixReceive);
    AppLogger.I().info('Going to Pix Receive');
  }

  void goToPixWithKey() {
    _track(20, 'Pix com Chave');
    Get.toNamed(AppRoutes.pixWithKey);
    AppLogger.I().info('Going to Pix With Key');
  }

  void goToScheduledPix() {
    _track(21, 'Pix Agendado');
    Get.toNamed(AppRoutes.pixScheduled);
    AppLogger.I().info('Going to Pix Scheduled');
  }

  void goToPixQrCodeReader() {
    _track(22, 'Pix com QR Code');
    Get.toNamed(AppRoutes.pixQrCodeReader);
    AppLogger.I().info('Going to Pix QR Code Reader');
  }

  void goToCopyPaste() {
    _track(23, 'Pix Copia e Cola');
    Get.toNamed(AppRoutes.pixCopyPaste);
    AppLogger.I().info('Going to Pix Copy Paste');
  }
}
