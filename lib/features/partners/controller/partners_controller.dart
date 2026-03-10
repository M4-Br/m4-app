import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/partners/model/partner_sale_history_model.dart';
import 'package:app_flutter_miban4/features/partners/model/partners_model.dart';
import 'package:app_flutter_miban4/features/partners/repository/partners_repository.dart';
import 'package:app_flutter_miban4/features/partners/repository/partner_sale_repository.dart';
import 'package:get/get.dart';

class PartnersController extends BaseController {
  final PartnerManagementRepository _repository = PartnerManagementRepository();
  final PartnerSaleRepository _saleRepository = PartnerSaleRepository();

  final RxList<PartnerCategory> categories = <PartnerCategory>[].obs;
  final RxString userRegion = 'Maringá'.obs;

  final RxInt myActiveProductsCount = 0.obs;
  final RxInt mySalesCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPartners();
  }

  Future<void> fetchPartners() async {
    await executeSafe(() async {
      isLoading.value = true;

      final results = await Future.wait([
        _repository.getCategories(),
        _repository.getProducts(),
        _saleRepository.getSales(),
      ]);

      final fetchedCategories = results[0] as List<PartnerCategory>;
      final allProducts = results[1] as List<PartnerItem>;
      final allSales = results[2] as List<PartnerSaleHistory>;

      // 1. Mapeia TODOS os produtos para as categorias (sem filtro de dono)
      final List<PartnerCategory> updatedCategories = [];
      for (var category in fetchedCategories) {
        final categoryProducts =
            allProducts.where((p) => p.categoryId == category.id).toList();

        updatedCategories.add(
          PartnerCategory(
            id: category.id,
            categoryName: category.categoryName,
            items: categoryProducts,
          ),
        );
      }
      categories.assignAll(updatedCategories);

      // 2. Calcula os indicadores apenas para o Widget de resumo

      // Meus Produtos (como vendedor)
      final myOwnProducts = allProducts
          .where((p) => p.userId == userRx.userId.toString())
          .toList();
      myActiveProductsCount.value = myOwnProducts.length;

      // Minhas Vendas (vendas que eu realizei como comprador)
      final mySales = allSales.where((s) => s.userId == userRx.userId).toList();
      mySalesCount.value = mySales.length;
    }, message: 'Erro ao carregar os dados de parceiros');

    isLoading.value = false;
  }

  void goToCheckout(PartnerItem item) {
    Get.toNamed(AppRoutes.partnerPurchase, arguments: {
      'item': item,
      'region': userRegion.value,
    });
  }
}
