import 'package:app_flutter_miban4/features/marketplace/controller/marketplace_new_item_controller.dart';
import 'package:get/get.dart';

class MarketplaceNewItemBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketplaceNewItemController>(
        () => MarketplaceNewItemController());
  }
}
