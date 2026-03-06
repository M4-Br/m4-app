import 'package:app_flutter_miban4/features/partners/controller/partner_purchase_controller.dart';
import 'package:get/get.dart';

class PartnerPurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartnerPurchaseController>(() => PartnerPurchaseController());
  }
}
