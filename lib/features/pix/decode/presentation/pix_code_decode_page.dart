import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/dates.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/pix/decode/controller/pix_code_decode_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixCodeDecodePage extends GetView<PixCodeDecodeController> {
  const PixCodeDecodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'PIX',
      ),
      body: CustomPageBody(
        padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
        children: [
          const SizedBox(height: 24),

          Center(
            child: AppText.titleLarge(
              context,
              'pix_youReceived'.tr,
            ),
          ),

          // Valor em Destaque
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Text('R\$ ',
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              Text(
                controller.qrData.finalAmount.toBRL(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 42,
                  color: secondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Center(
              child: AppText.titleMedium(
            context,
            controller.qrData.title,
          )),
          const SizedBox(height: 8),
          Center(
              child:
                  AppText.bodyMedium(context, controller.qrData.description)),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Colors.grey),
          ),

          _buildInfoRow(
              'pix_day'.tr,
              controller.qrData.dueDate?.toDDMMYYYY() ??
                  DateTime.now().toDDMMYYYY(),
              icon: Icons.calendar_today_outlined),
          _buildInfoRow('pix_to'.tr, controller.qrData.payee.name),
          _buildInfoRow('CPF/CNPJ',
              controller.formatCPF(controller.qrData.payee.document)),
          _buildInfoRow(
              'transfer_institution'.tr, controller.qrData.payee.bankName),
          _buildInfoRow('pix_city'.tr, controller.qrData.city),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: Colors.grey),
          ),
          _buildInfoRow('transfer_debtor'.tr, controller.qrData.payer.name),
          _buildInfoRow('CPF/CNPJ', controller.payerDocumentMasked),
          _buildInfoRow('pix_originalAmount'.tr,
              'R\$ ${controller.qrData.finalAmount.toBRL()}'),

          const SizedBox(height: 40),

          Center(
            child: Obx(() => Text(
                  controller.hasSufficientBalance
                      ? "${'balance_available'.tr} ${controller.balanceRx.balance.value!.balanceCents.toBRL()}"
                      : "${'balance_available'.tr} ${controller.balanceRx.balance.value!.balanceCents.toBRL()}",
                  style: TextStyle(
                      color: controller.hasSufficientBalance
                          ? Colors.black
                          : Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: AppButton(
                  labelText: 'cancel'.tr.toUpperCase(),
                  onPressed: () async => Get.back(),
                  buttonType: AppButtonType.filled,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Obx(() => AppButton(
                      labelText: 'confirm'.tr.toUpperCase(),
                      onPressed: controller.hasSufficientBalance
                          ? () async => controller.openPasswordDialog()
                          : null,
                      color: secondaryColor,
                      isLoading: controller.isLoading.value,
                    )),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 16, color: Colors.black)),
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: Colors.black),
                const SizedBox(width: 4),
              ],
              Text(
                value,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          )
        ],
      ),
    );
  }
}
