import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/currency_formatter.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/TED/controller/transfer_value_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TransferValuePage extends GetView<TransferValueController> {
  const TransferValuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'transfer'.tr,
      ),
      body: CustomPageBody(
        padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
        children: [
          const SizedBox(height: 40),

          Center(
            child: AppText.titleLarge(
              context,
              'transfer_value'.tr,
              color: Colors.black87,
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 8),

          Center(
            child: AppText.bodyMedium(
              context,
              'Para: ${controller.userDestiny.name}',
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 40),

          // Input Gigante de Valor
          TextField(
            controller: controller.amountController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: secondaryColor,
            ),
            decoration: const InputDecoration(
              hintText: 'R\$ 0,00',
              hintStyle: TextStyle(fontSize: 40, color: Colors.grey),
              border: InputBorder.none,
              prefixStyle: TextStyle(
                  color: secondaryColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyFormatter()
            ],
          ),
          const Spacer(),
          Center(
            child: Obx(() {
              final hasBalance = controller.hasBalance;
              return Text(
                "${'balance_available'.tr}: ${controller.balanceRx.balance.value!.balanceCents.toBRL()}",
                style: TextStyle(
                  color: hasBalance ? Colors.grey.shade700 : Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              );
            }),
          ),

          const SizedBox(height: 24),

          Obx(() => SizedBox(
                width: double.infinity,
                child: AppButton(
                  labelText: 'next'.tr.toUpperCase(),
                  color: secondaryColor,
                  isLoading: controller.isLoading.value,
                  onPressed: () async => controller.isValidAmount.value
                      ? controller.onNext()
                      : null,
                ),
              )),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
