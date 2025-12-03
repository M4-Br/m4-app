import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/pix/transfer/controller/pix_transfer_controller.dart';

class PixTransferBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PixTransferController>(
      () => PixTransferController(Get.find<BalanceRx>()),
    );
  }
}
