import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/currency_formatter.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/partners/controller/partner_new_item_controller.dart';
import 'package:app_flutter_miban4/features/partners/model/partners_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PartnerNewItemPage extends GetView<PartnerNewItemController> {
  const PartnerNewItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Parceiros',
      ),
      body: CustomPageBody(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),

          // Região
          Row(
            children: [
              AppText.bodyLarge(context, 'REGIÃO:', color: Colors.black54),
              const SizedBox(width: 32),
              AppText.bodyLarge(context, 'Maringá', color: Colors.black87),
            ],
          ),
          const SizedBox(height: 32),

          AppText.titleLarge(context, 'NOVO ITEM', color: Colors.black87),
          const SizedBox(height: 24),

          Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<PartnerCategory>(
                    decoration: const InputDecoration(
                        labelText: 'Categoria', border: UnderlineInputBorder()),
                    initialValue: controller.selectedCategory.value,
                    items: controller.availableCategories.map((cat) {
                      return DropdownMenuItem(
                        value: cat,
                        child: Text(
                          cat.categoryName,
                          style: TextStyle(
                            fontWeight:
                                cat.categoryName == '+ Criar nova categoria'
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color: cat.categoryName == '+ Criar nova categoria'
                                ? primaryColor
                                : Colors.black87,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: controller.onCategoryChanged,
                  ),
                  if (controller.isCreatingCategory.value) ...[
                    const SizedBox(height: 16),
                    TextField(
                      controller: controller.newCategoryController,
                      decoration: const InputDecoration(
                          labelText: 'Nome da Nova Categoria',
                          border: UnderlineInputBorder()),
                    ),
                  ],
                ],
              )),
          const SizedBox(height: 16),

          // Nome do Produto
          TextField(
            controller: controller.nameController,
            decoration: const InputDecoration(
                labelText: 'Nome do Produto', border: UnderlineInputBorder()),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: controller.descriptionController,
            decoration: const InputDecoration(
                labelText: 'Descrição (opcional)',
                border: UnderlineInputBorder()),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: controller.marketValueController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyFormatter()
            ],
            decoration: const InputDecoration(
                labelText: 'Valor Atual (R\$)', border: UnderlineInputBorder()),
          ),
          const SizedBox(height: 16),

          // Valor Parceiros
          TextField(
            controller: controller.partnerValueController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyFormatter()
            ],
            decoration: const InputDecoration(
                labelText: 'Valor Parceiros (R\$)',
                border: UnderlineInputBorder()),
          ),
          const SizedBox(height: 32),

          Obx(() {
            final discountStr = controller.calculatedDiscount.value
                .toStringAsFixed(2)
                .replaceAll('.', ',');

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.bodyLarge(context, 'Desconto:', color: Colors.black54),
                AppText.bodyLarge(context, 'R\$ $discountStr',
                    color: Colors.green),
              ],
            );
          }),

          const Spacer(),
          Obx(() => AppButton(
                labelText: 'CONFIRMAR',
                buttonType: AppButtonType.filled,
                isLoading: controller.isLoading.value,
                onPressed: controller.confirmRegistration,
              )),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
