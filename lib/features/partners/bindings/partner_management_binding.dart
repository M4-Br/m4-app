import 'package:app_flutter_miban4/features/partners/controller/partner_management_controller.dart';
import 'package:get/get.dart';

class PartnerManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartnerManagementController>(
        () => PartnerManagementController());
  }
}
