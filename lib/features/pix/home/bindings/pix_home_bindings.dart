import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:app_flutter_miban4/features/pix/home/controller/pix_home_controller.dart';
import 'package:get/get.dart';

class PixHomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PixHomeController>(
        () => PixHomeController(balance: Get.find<BalanceRx>()));
  }
}
