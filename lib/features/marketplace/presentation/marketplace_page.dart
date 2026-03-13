import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/marketplace/controller/marketplace_controller.dart';
import 'package:app_flutter_miban4/features/marketplace/model/partners_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketplacePage extends GetView<MarketplaceController> {
  const MarketplacePage({super.key});

  final Color _greenDark = const Color(0xFF065F46);
  final Color _bgLight = const Color(0xFFF8F9FA);
  final Color _textDark = const Color(0xFF1F2937);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: AppBar(
        backgroundColor: _greenDark,
        elevation: 0,
        titleSpacing: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.storefront_outlined, color: Colors.white),
            onPressed: () => Get.toNamed(AppRoutes.stock),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildHeaderAndSearch(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.serverCategories.isEmpty) {
                return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF065F46)));
              }

              // Verifica se a lista processada tem algum produto para mostrar
              final hasAnyProduct =
                  controller.filteredCategoriesToDisplay.isNotEmpty;

              return CustomPageBody(
                enableIntrinsicHeight: false,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  _buildCategoryFilters(context),
                  const SizedBox(height: 24),
                  if (hasAnyProduct)
                    ...controller.filteredCategoriesToDisplay.map(
                        (category) => _buildCategorySection(context, category))
                  else
                    _buildEmptyState(),
                  const SizedBox(height: 40),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderAndSearch() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          color: _greenDark,
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 40, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Row(
                children: [
                  Icon(Icons.storefront, color: Colors.white, size: 28),
                  SizedBox(width: 8),
                  Text('Marketplace',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 8),
              Text('Compre online e ganhe 5% de cashback',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        ),
        Positioned(
          bottom: -24,
          left: 16,
          right: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4)),
              ],
            ),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Buscar produtos...',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- FILTROS DE CATEGORIA DINÂMICOS ---
  Widget _buildCategoryFilters(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: ScrollConfiguration(
        // ISSO AQUI É A MÁGICA PARA A WEB: Permite arrastar com o mouse!
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse, // <--- Libera o drag no desktop
          },
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics:
              const BouncingScrollPhysics(), // Dá aquele efeito elástico legal nas bordas
          child: Row(
            children: [
              // Botão Fixo "Todos" que atua como reset
              Obx(() => _buildFilterChip(
                  'Todos', controller.selectedCategoryFilter.value == 'Todos')),

              // Renderiza TODAS as categorias do servidor
              ...controller.serverCategories.map((c) {
                return Obx(() {
                  final isSelected =
                      controller.selectedCategoryFilter.value == c.categoryName;
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: _buildFilterChip(c.categoryName, isSelected),
                  );
                });
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return InkWell(
      onTap: () => controller.selectCategory(label),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF059669) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? null : Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined,
              size: 48, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text('Nenhum produto encontrado',
              style: TextStyle(
                  color: _textDark, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Tente ajustar os filtros de busca',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildCategorySection(
      BuildContext context, MarketplaceCategory category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          category.categoryName.toUpperCase(),
          style: const TextStyle(
              color: Color(0xFF065F46),
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        const SizedBox(height: 12),
        ListView.separated(
            shrinkWrap: true,
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: category.items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = category.items[index];
              return InkWell(
                onTap: () => controller.goToCheckout(item),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.image_outlined,
                            color: Colors.grey),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name,
                                style: TextStyle(
                                    color: _textDark,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                            if (item.description.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(item.description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600)),
                            ]
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(item.marketplaceValue.toBRL(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF059669))),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
