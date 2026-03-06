import 'package:app_flutter_miban4/features/partners/controller/partner_new_item_controller.dart';
import 'package:get/get.dart';

class PartnerNewItemBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartnerNewItemController>(() => PartnerNewItemController());
  }
}
