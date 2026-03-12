import 'package:app_flutter_miban4/features/marketplace/controller/marketplace_purchase_controller.dart';
import 'package:get/get.dart';

class MarketplacePurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketplacePurchaseController>(
        () => MarketplacePurchaseController());
  }
}
