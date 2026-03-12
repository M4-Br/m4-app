import 'package:app_flutter_miban4/features/marketplace/controller/marketplace_management_controller.dart';
import 'package:get/get.dart';

class MarketplaceManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketplaceManagementController>(
        () => MarketplaceManagementController());
  }
}
