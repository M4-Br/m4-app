import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/TED/controller/transfer_success_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferSuccessPage extends GetView<TransferSuccessController> {
  const TransferSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'transfer'.tr,
        onBackPressed: controller.goToHome,
      ),
      body: CustomPageBody(
        padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
        children: [
          const SizedBox(height: 32),

          Center(
            child: AppText.titleLarge(
              context,
              'transfer_success'.tr,
              textAlign: TextAlign.center,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 32),

          // Linha Valor
          _buildInfoRow(
            context,
            'transfer_valueConfirm'.tr,
            controller.voucher.values?.originalAmount?.centsToBRL() ?? '',
            isHighlight: true,
          ),

          // Linha Data
          _buildInfoRow(
            context,
            'transfer_date'.tr,
            controller.voucher.transactionDate ?? '',
          ),

          // Linha Nome
          _buildInfoRow(
            context,
            'transfer_to_confirm'.tr,
            controller.receiverName,
          ),

          // Linha CPF
          _buildInfoRow(
            context,
            'CPF:',
            controller.receiverDocFormatted,
          ),

          // Linha Banco
          _buildInfoRow(
            context,
            'transfer_bank'.tr,
            controller.bankName,
          ),

          _buildInfoRow(
            context,
            'transfer_account'.tr,
            'M4',
          ),

          // Linha Taxas
          _buildInfoRow(
            context,
            'transfer_fees'.tr,
            'R\$ 0,00',
          ),

          const Spacer(),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: controller.goToVoucherDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                elevation: 0,
              ),
              child: Text(
                'transfer_voucher'.tr,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: controller.goToNewTransfer,
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
              child: Text(
                'transfer_new'.tr, // "Nova Transferência"
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value,
      {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 16,
                color: isHighlight ? secondaryColor : Colors.black87,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
