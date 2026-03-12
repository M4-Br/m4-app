import 'package:app_flutter_miban4/features/marketplace/controller/marketplace_controller.dart';
import 'package:get/get.dart';

class MarketplaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketplaceController>(() => MarketplaceController());
  }
}
