import 'package:app_flutter_miban4/features/TED/controller/transfer_success_controller.dart';
import 'package:get/get.dart';

class TransferSuccessBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransferSuccessController>(() => TransferSuccessController());
  }
}
