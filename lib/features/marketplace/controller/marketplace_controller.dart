import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/marketplace/model/partner_sale_history_model.dart';
import 'package:app_flutter_miban4/features/marketplace/model/partners_model.dart';
import 'package:app_flutter_miban4/features/marketplace/repository/marketplace_repository.dart';
import 'package:app_flutter_miban4/features/marketplace/repository/marketplace_sale_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketplaceController extends BaseController {
  final MarketplaceManagementRepository _repository =
      MarketplaceManagementRepository();
  final MarketplaceSaleRepository _saleRepository = MarketplaceSaleRepository();

  // --- ESTADOS SEPARADOS ---
  // 1. Categorias fiéis do servidor (Apenas para desenhar os Chips)
  final RxList<MarketplaceCategory> serverCategories =
      <MarketplaceCategory>[].obs;
  // 2. Todos os produtos brutos do servidor
  final RxList<MarketplaceItem> allProducts = <MarketplaceItem>[].obs;
  // 3. Lista final mastigada que vai pra tela renderizar os cards
  final RxList<MarketplaceCategory> filteredCategoriesToDisplay =
      <MarketplaceCategory>[].obs;

  final RxString userRegion = 'Maringá'.obs;
  final RxInt myActiveProductsCount = 0.obs;
  final RxInt mySalesCount = 0.obs;

  final searchController = TextEditingController();
  final RxString selectedCategoryFilter =
      'Todos'.obs; // "Todos" reseta o filtro

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(applyFilters);
    fetchMarketplace();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> fetchMarketplace() async {
    await executeSafe(() async {
      isLoading.value = true;

      final results = await Future.wait([
        _repository.getCategories(),
        _repository.getProducts(),
        _saleRepository.getSales(),
      ]);

      // Popula os dados base
      serverCategories.assignAll(results[0] as List<MarketplaceCategory>);
      allProducts.assignAll(results[1] as List<MarketplaceItem>);
      final allSales = results[2] as List<MarketplaceSaleHistory>;

      // Roda o filtro inicial para montar a tela
      applyFilters();

      // Calcula indicadores do usuário logado
      final myOwnProducts = allProducts
          .where((p) => p.userId == userRx.userId.toString())
          .toList();
      myActiveProductsCount.value = myOwnProducts.length;

      final mySales = allSales.where((s) => s.userId == userRx.userId).toList();
      mySalesCount.value = mySales.length;
    }, message: 'Erro ao carregar os dados de parceiros');

    isLoading.value = false;
  }

  // --- LÓGICA DE FILTRO CRUZADO ---
  void selectCategory(String categoryName) {
    selectedCategoryFilter.value = categoryName;
    applyFilters();
  }

  void applyFilters() {
    final query = searchController.text.toLowerCase();
    final currentCategory = selectedCategoryFilter.value;

    List<MarketplaceCategory> displayList = [];

    // Itera sobre as categorias base do servidor
    for (var cat in serverCategories) {
      // 1. Filtro do Chip: Se não for "Todos" e a categoria for diferente, ignora.
      if (currentCategory != 'Todos' && cat.categoryName != currentCategory) {
        continue;
      }

      // 2. Pega os produtos que pertencem a esta categoria
      var categoryProducts =
          allProducts.where((p) => p.categoryId == cat.id).toList();

      // 3. Filtro de Texto (Pesquisa)
      if (query.isNotEmpty) {
        categoryProducts = categoryProducts.where((item) {
          return item.name.toLowerCase().contains(query) ||
              item.description.toLowerCase().contains(query);
        }).toList();
      }

      // 4. Se sobrou algum produto, adicionamos a categoria inteira na lista final
      if (categoryProducts.isNotEmpty) {
        displayList.add(
          MarketplaceCategory(
            id: cat.id,
            categoryName: cat.categoryName,
            items: categoryProducts,
          ),
        );
      }
    }

    filteredCategoriesToDisplay.assignAll(displayList);
  }

  void goToCheckout(MarketplaceItem item) {
    Get.toNamed(AppRoutes.marketplacePurchase, arguments: {
      'item': item,
      'region': userRegion.value,
    });
  }
}
