import 'package:app_flutter_miban4/features/cashback/controller/cashback_controller.dart';
import 'package:get/get.dart';

class CashbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashbackController>(() => CashbackController());
  }
}
