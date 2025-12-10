import 'package:app_flutter_miban4/features/TED/controller/transfer_contacts_controller.dart';
import 'package:get/get.dart';

class TransferContactsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransferContactsController>(() => TransferContactsController());
  }
}
