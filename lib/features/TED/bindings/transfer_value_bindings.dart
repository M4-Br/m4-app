import 'package:app_flutter_miban4/features/TED/controller/transfer_value_controller.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:get/get.dart';

class TransferValueBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransferValueController>(
        () => TransferValueController(Get.find<BalanceRx>()));
  }
}
