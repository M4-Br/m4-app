import 'package:app_flutter_miban4/features/TED/controller/transfer_voucer_controller.dart';
import 'package:get/get.dart';

class TransferVoucherBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransferVoucherController>(() => TransferVoucherController());
  }
}
