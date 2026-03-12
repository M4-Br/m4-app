import 'package:app_flutter_miban4/features/marketplace/controller/marketplace_sale_history.dart';
import 'package:get/get.dart';

class MarketplaceSalesHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketplaceSaleHistoryController>(
        () => MarketplaceSaleHistoryController());
  }
}
