import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/marketplace/controller/marketplace_purchase_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketplacePurchasePage extends GetView<MarketplacePurchaseController> {
  const MarketplacePurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final valMercado = 'R\$ ${controller.item.marketValue.toBRL()}';
    final valDesconto = 'R\$ ${controller.item.discount.toBRL()}';
    final valParceiro = 'R\$ ${controller.item.marketplaceValue.toBRL()}';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'PARCEIROS',
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
              AppText.bodyLarge(context, controller.region,
                  color: Colors.black87),
            ],
          ),
          const SizedBox(height: 32),

          Center(
            child: AppText.titleMedium(context, 'Produtos / Serviços',
                color: Colors.black87),
          ),
          const SizedBox(height: 48),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.titleLarge(context, controller.item.name,
                        color: Colors.black87),
                    if (controller.item.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      AppText.bodyMedium(context, controller.item.description,
                          color: Colors.black54),
                    ],
                  ],
                ),
              ),
              AppText.titleLarge(context, valParceiro, color: secondaryColor),
            ],
          ),

          const SizedBox(height: 32),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: AppText.bodyMedium(context, controller.operationId,
                color: Colors.black54),
          ),

          const SizedBox(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.bodyLarge(context, 'Valor Mercado:',
                  color: Colors.black54),
              AppText.bodyLarge(context, valMercado, color: Colors.black87),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.bodyLarge(context, 'Desconto Parceiros:',
                  color: Colors.black54),
              AppText.bodyLarge(context, valDesconto, color: Colors.green),
            ],
          ),

          const Spacer(),

          Obx(() => AppButton(
                labelText: 'CONFIRMAR',
                buttonType: AppButtonType.filled,
                isLoading: controller.isLoading.value,
                onPressed: () async {
                  controller.passwordController.clear();

                  CustomDialogs.showWidgetDialog(
                    title: 'Digite sua senha',
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: controller.passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 6,
                          decoration: const InputDecoration(
                            counterText: '',
                            hintText: '******',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                    confirmText: 'CONFIRMAR',
                    onConfirm: controller.verifyPasswordAndConfirm,
                  );
                },
              )),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
