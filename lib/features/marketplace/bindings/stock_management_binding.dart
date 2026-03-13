import 'package:app_flutter_miban4/features/marketplace/controller/stock_management_controller.dart';
import 'package:get/get.dart';

class StockManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockManagementController>(() => StockManagementController());
  }
}
