import 'package:app_flutter_miban4/features/TED/controller/transfer_bank_choose_controller.dart';
import 'package:get/get.dart';

class TransferBankChooseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransferBankController>(() => TransferBankController());
  }
}
