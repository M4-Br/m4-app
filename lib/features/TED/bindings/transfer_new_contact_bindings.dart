import 'package:app_flutter_miban4/features/TED/controller/transfer_new_contact_controller.dart';
import 'package:get/get.dart';

class TransferNewContactBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransferNewContactController>(
        () => TransferNewContactController());
  }
}
