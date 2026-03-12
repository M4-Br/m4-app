import 'package:app_flutter_miban4/features/marketplace/controller/marketplace_receipt_controller.dart';
import 'package:get/get.dart';

class MarketplaceReceiptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketplaceReceiptController>(
        () => MarketplaceReceiptController());
  }
}
