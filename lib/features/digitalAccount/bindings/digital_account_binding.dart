import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:app_flutter_miban4/features/digitalAccount/controller/digital_account_controller.dart';
import 'package:get/get.dart';

class DigitalAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DigitalAccountController>(
        () => DigitalAccountController(Get.find<BalanceRx>()));
  }
}
