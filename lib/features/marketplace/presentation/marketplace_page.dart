import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/marketplace/controller/marketplace_controller.dart';
import 'package:app_flutter_miban4/features/marketplace/model/partners_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketplacePage extends GetView<MarketplaceController> {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'PARCEIROS'),
      body: Obx(() {
        if (controller.isLoading.value && controller.categories.isEmpty) {
          return const Center(
              child: CircularProgressIndicator(color: primaryColor));
        }

        final hasAnyProduct =
            controller.categories.any((category) => category.items.isNotEmpty);

        return CustomPageBody(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          enableIntrinsicHeight: false,
          children: [
            const SizedBox(height: 24),
            _buildRegionHeader(context),
            const SizedBox(height: 32),
            AppText.titleLarge(context, 'PRODUTOS', color: Colors.black87),
            const SizedBox(height: 16),

            if (hasAnyProduct)
              ...controller.categories
                  .map((category) => _buildCategorySection(context, category))
            else
              _buildEmptyState(context),

            const SizedBox(height: 32),
            const Divider(color: Colors.black12),
            const SizedBox(height: 24),

            AppText.titleMedium(context, 'SUA GESTÃO', color: Colors.black87),
            const SizedBox(height: 16),

            // Grid de Botões de Gestão
            Row(
              children: [
                _buildManagementCard(
                  context,
                  title: 'Meus Itens',
                  count: controller.myActiveProductsCount.value,
                  icon: Icons.inventory_2_outlined,
                  onTap: () => Get.toNamed(AppRoutes.marketplaceManagement)
                      ?.then((_) => controller.fetchMarketplace()),
                ),
                const SizedBox(width: 16),
                _buildManagementCard(
                  context,
                  title: 'Minhas Vendas',
                  count: controller.mySalesCount.value,
                  icon: Icons.receipt_long_outlined,
                  onTap: () => Get.toNamed(AppRoutes.marketplacealeHistory),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        );
      }),
    );
  }

  Widget _buildRegionHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: primaryColor, size: 20),
          const SizedBox(width: 12),
          AppText.bodyLarge(context, 'REGIÃO:', color: Colors.black54),
          const SizedBox(width: 8),
          AppText.bodyLarge(
            context,
            controller.userRegion.value,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }

  Widget _buildManagementCard(BuildContext context,
      {required String title,
      required int count,
      required IconData icon,
      required VoidCallback onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: primaryColor),
              const SizedBox(height: 12),
              AppText.bodyMedium(context, title, color: Colors.black54),
              const SizedBox(height: 4),
              Text(
                count.toString().padLeft(2, '0'),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.shopping_bag_outlined,
                size: 48, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            AppText.bodyLarge(context, 'Não há produtos em sua região',
                color: Colors.black45),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(
      BuildContext context, MarketplaceCategory category) {
    if (category.items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            AppText.bodyMedium(
              context,
              category.categoryName.toUpperCase(),
              color: primaryColor,
            ),
            const SizedBox(width: 12),
            const Expanded(child: Divider(color: Colors.black12)),
          ],
        ),
        const SizedBox(height: 8),
        ...category.items.map((item) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: AppText.bodyMedium(
                context,
                item.name,
              ),
              subtitle: item.description.isNotEmpty
                  ? Text(item.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black45))
                  : null,
              trailing: Text(
                item.marketplaceValue.toBRL(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              onTap: () => controller.goToCheckout(item),
            )),
      ],
    );
  }
}
