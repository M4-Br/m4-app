import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/pix/voucher/controller/pix_voucher_controller.dart';

class PixVoucherBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PixVoucherController>(
      () => PixVoucherController(),
    );

    AppLogger.I().info('Pix voucher dependencies injected');
  }
}
