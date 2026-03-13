import 'package:app_flutter_miban4/features/contact/controller/contact_controller.dart';
import 'package:get/get.dart';

class ContactsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(() => ContactController());
  }
}
