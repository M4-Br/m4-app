import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/TED/controller/transfer_voucer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferVoucherPage extends GetView<TransferVoucherController> {
  const TransferVoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'transfer_receipt'.tr,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: controller.closeVoucher,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
              child: RepaintBoundary(
                key: controller.voucherRepaintKey,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const Icon(Icons.check_circle,
                                color: secondaryColor, size: 64),
                            const SizedBox(height: 16),
                            AppText.headlineSmall(
                              context,
                              'Transferência realizada!',
                              color: Colors.black87,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            AppText.bodyMedium(
                              context,
                              controller.voucher.transactionDate ?? '',
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Divider(),
                      const SizedBox(height: 24),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Valor da transferência',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 4),
                            AppText.headlineMedium(
                              context,
                              controller.voucher.values?.originalAmount
                                      ?.centsToBRL() ??
                                  '',
                              color: secondaryColor,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildSectionTitle('transfer_destiny'.tr),
                      _buildDetailRow(context, 'Nome', controller.receiverName),
                      _buildDetailRow(
                          context, 'CPF/CNPJ', controller.receiverDoc),
                      _buildDetailRow(
                          context, 'Instituição', controller.receiverBank),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),
                      _buildSectionTitle('transfer_origin'.tr),
                      _buildDetailRow(context, 'Nome', controller.payerName),
                      _buildDetailRow(context, 'CPF/CNPJ', controller.payerDoc),
                      _buildDetailRow(context, 'Instituição', 'Miban4'),
                      const SizedBox(height: 24),
                      Center(
                        child: AppText.bodySmall(
                          context,
                          'ID Transação: ${controller.transactionId}',
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Obx(
                  () => controller.isLoading.value
                      ? const Center(
                          child:
                              CircularProgressIndicator(color: secondaryColor))
                      : ElevatedButton.icon(
                          icon: const Icon(Icons.share_outlined,
                              color: Colors.white),
                          label: Text(
                            'invoice_share'.tr,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: controller.shareVoucher,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child:
                AppText.bodyMedium(context, label, color: Colors.grey.shade600),
          ),
          Expanded(
            flex: 3,
            child: AppText.bodyMedium(
              context,
              value,
              color: Colors.black87,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
