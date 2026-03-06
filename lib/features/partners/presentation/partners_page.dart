import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/partners/controller/partners_controller.dart';
import 'package:app_flutter_miban4/features/partners/model/partners_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartnersPage extends GetView<PartnersController> {
  const PartnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'PARCEIROS',
      ),
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

            // Região
            Row(
              children: [
                AppText.bodyLarge(context, 'REGIÃO:', color: Colors.black54),
                const SizedBox(width: 32),
                AppText.bodyLarge(context, controller.userRegion.value,
                    color: Colors.black87),
              ],
            ),

            const SizedBox(height: 32),
            AppText.titleLarge(context, 'PRODUTOS', color: Colors.black87),
            const SizedBox(height: 24),

            if (hasAnyProduct)
              ...controller.categories
                  .map((category) => _buildCategorySection(context, category))
            else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: AppText.bodyLarge(
                      context, 'Não há produtos em sua região',
                      color: Colors.black54),
                ),
              ),

            const SizedBox(height: 40),
            const Divider(height: 1, color: Colors.black12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: AppText.bodyLarge(context, 'CADASTRO PRÓPRIO - ativos',
                  color: Colors.black54),
              trailing: Text(
                controller.myActiveProductsCount.value
                    .toString()
                    .padLeft(2, '0'),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              onTap: () {
                Get.toNamed(AppRoutes.partnerManagement)?.then((_) {
                  controller.fetchPartners();
                });
              },
            ),
            const SizedBox(height: 40),
          ],
        );
      }),
    );
  }

  Widget _buildCategorySection(BuildContext context, PartnerCategory category) {
    if (category.items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppText.bodyMedium(context, category.categoryName,
                color: Colors.black54),
            const SizedBox(width: 8),
            const Expanded(
              child: Divider(
                height: 1,
                thickness: 1,
                color: Colors.black26,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...category.items.map((item) {
          final formattedValue = 'R\$ ${item.partnerValue.toBRL()}';

          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: AppText.bodyMedium(context, item.name),
            trailing: Text(
              formattedValue,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            onTap: () => controller.goToCheckout(item),
          );
        }),
        const SizedBox(height: 24),
      ],
    );
  }
}
