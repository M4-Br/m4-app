import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/partners/model/partner_sale_history_model.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/partners/repository/partner_sale_repository.dart';

class PartnerSaleHistoryController extends BaseController {
  final PartnerSaleRepository _repository = PartnerSaleRepository();

  final RxList<PartnerSaleHistory> sales = <PartnerSaleHistory>[].obs;

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
