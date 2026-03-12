import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/currency_formatter.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/marketplace/controller/marketplace_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MarketplaceManagementPage
    extends GetView<MarketplaceManagementController> {
  const MarketplaceManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'MEUS PRODUTOS',
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.myProducts.isEmpty) {
          return const Center(
              child: CircularProgressIndicator(color: primaryColor));
        }

        return CustomPageBody(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          enableIntrinsicHeight: false,
          children: [
            const SizedBox(height: 24),
            Row(
              children: [
                AppText.bodyLarge(context, 'REGIÃO:', color: Colors.black54),
                const SizedBox(width: 32),
                AppText.bodyLarge(context, controller.userRegion.value,
                    color: Colors.black87),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.bodyLarge(context, 'CADASTRO PRÓPRIO - ativos',
                    color: Colors.black54),
                Text(
                  controller.myProducts.length.toString().padLeft(2, '0'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 24),
            AppText.titleLarge(context, 'MEUS PRODUTOS', color: Colors.black87),
            const SizedBox(height: 16),
            if (controller.myProducts.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(
                    child: Text('Você ainda não possui itens cadastrados.')),
              )
            else
              ...controller.myProducts.map((item) {
                final formattedValue = item.marketplaceValue.toBRL();

                return GestureDetector(
                  onDoubleTap: () => controller.confirmDeletion(item),
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: AppText.bodyMedium(
                        context,
                        item.name,
                      ),
                      subtitle: AppText.bodySmall(context, 'Toque para editar',
                          color: Colors.black45),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            formattedValue,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Botão explícito de deletar
                          IconButton(
                            icon: const Icon(Icons.delete_outline,
                                color: Colors.redAccent),
                            onPressed: () => controller.confirmDeletion(item),
                          ),
                        ],
                      ),
                      onTap: () {
                        controller.prepareEdit(item);
                        _showEditBottomSheet(context);
                      },
                    ),
                  ),
                );
              }),
            const SizedBox(height: 40),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: AppText.bodyLarge(context, 'NOVO ITEM',
                  color: Colors.black87),
              trailing:
                  AppText.bodyLarge(context, 'PRODUTO', color: Colors.black54),
              onTap: controller.goToNewItem,
            ),
            const SizedBox(height: 40),
          ],
        );
      }),
    );
  }

  void _showEditBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(
          top: 24,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText.titleMedium(context, 'EDITAR PRODUTO',
                  color: Colors.black87),
              const SizedBox(height: 24),
              TextField(
                controller: controller.editNameCtrl,
                decoration: const InputDecoration(
                    labelText: 'Nome do Produto',
                    border: UnderlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.editDescCtrl,
                decoration: const InputDecoration(
                    labelText: 'Descrição (opcional)',
                    border: UnderlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.editMarketCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyFormatter()
                ],
                decoration: const InputDecoration(
                    labelText: 'Valor Atual (R\$)',
                    border: UnderlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.editMarketplaceCtrl,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyFormatter()
                ],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                    labelText: 'Valor Parceiros (R\$)',
                    border: UnderlineInputBorder()),
              ),
              const SizedBox(height: 32),
              Obx(() {
                final discountStr = controller.editDiscount.value.toBRL();

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.bodyLarge(context, 'Desconto:',
                        color: Colors.black54),
                    AppText.bodyLarge(context, discountStr,
                        color: Colors.green),
                  ],
                );
              }),
              const SizedBox(height: 32),
              Obx(() => AppButton(
                    labelText: 'SALVAR ALTERAÇÕES',
                    buttonType: AppButtonType.filled,
                    isLoading: controller.isLoading.value,
                    onPressed: controller.saveEditedItem,
                  )),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
