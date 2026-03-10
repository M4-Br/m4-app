import 'package:app_flutter_miban4/features/partners/controller/partner_sale_history.dart';
import 'package:get/get.dart';

class PartnerSalesHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartnerSaleHistoryController>(
        () => PartnerSaleHistoryController());
  }
}
