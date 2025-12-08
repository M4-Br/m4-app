import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/pix/decode/controller/pix_code_decode_controller.dart';

class PixCodeDecodeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PixCodeDecodeController>(
      () => PixCodeDecodeController(Get.find<BalanceRx>()),
    );

    AppLogger.I().info('Pix code decode dependencies injected');
  }
}
