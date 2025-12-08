import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/dates.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/controller/barcode_voucher_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BarcodeVoucherPage extends GetView<BarcodeVoucherController> {
  const BarcodeVoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: 'statement_title'.tr,
        onBackPressed: () => controller.closeVoucher(),
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
                      // Cabeçalho
                      Center(
                        child: Column(
                          children: [
                            const Icon(Icons.check_circle,
                                color: Colors.green, size: 64),
                            const SizedBox(height: 16),
                            AppText.headlineSmall(
                              context,
                              controller.paymentType,
                              color: Colors.black87,
                            ),
                            const SizedBox(height: 8),
                            AppText.bodyMedium(
                              context,
                              controller.voucherData.dueDate.toDDMMYYYY(),
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),
                      const Divider(),
                      const SizedBox(height: 24),

                      // Detalhes
                      _buildDetailRow(context, 'Status', controller.status),

                      const SizedBox(height: 16),

                      _buildDetailRow(context, 'statement_code'.tr,
                          controller.transactionId,
                          isCode: true),

                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),

                      // Valor em Destaque
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.bodyLarge(context, 'statement_value'.tr,
                              color: Colors.grey.shade600),
                          AppText.headlineSmall(
                            context,
                            controller.voucherData.amount.toBRL(),
                            color: secondaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Rodapé Fixo
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

  Widget _buildDetailRow(BuildContext context, String label, String value,
      {bool isCode = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              maxLines: isCode ? 3 : 1,
            ),
          ),
        ],
      ),
    );
  }
}
