import 'package:app_flutter_miban4/features/partners/controller/partner_receipt_controller.dart';
import 'package:get/get.dart';

class PartnerReceiptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartnerReceiptController>(() => PartnerReceiptController());
  }
}
