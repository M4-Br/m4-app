import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/marketplace/model/partner_sale_history_model.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/marketplace/repository/marketplace_sale_repository.dart';

class MarketplaceSaleHistoryController extends BaseController {
  final MarketplaceSaleRepository _repository = MarketplaceSaleRepository();

  final RxList<MarketplaceSaleHistory> sales = <MarketplaceSaleHistory>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSales();
  }

  Future<void> fetchSales() async {
    await executeSafe(() async {
      final result = await _repository.getSales();
      sales.assignAll(result);
    }, message: 'Não foi possível carregar o histórico de vendas.');
  }
}
