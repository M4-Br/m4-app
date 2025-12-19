import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/pix/voucher/controller/pix_voucher_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixVoucherPage extends GetView<PixVoucherController> {
  const PixVoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: 'pix_withKey'.tr,
        onBackPressed: controller.closeVoucher,
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
                        color: Colors.black.withValues(alpha: 0.05),
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
                                color: Colors.green, size: 64),
                            const SizedBox(height: 16),
                            AppText.headlineSmall(
                              context,
                              'pix_success'.tr,
                              color: Colors.black87,
                            ),
                            const SizedBox(height: 8),
                            AppText.bodyMedium(
                              context,
                              controller.formattedDate,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Divider(),
                      const SizedBox(height: 24),
                      Center(
                        child: AppText.bodySmall(
                          context,
                          controller.formattedAmount,
                          color: secondaryColor,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildDetailRow(context, 'statement_destiny'.tr,
                          controller.receiverName),
                      _buildDetailRow(context, 'statement_institute'.tr,
                          controller.bankName),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),
                      _buildDetailRow(
                          context, 'statement_origin'.tr, controller.payerName),
                      const SizedBox(height: 24),
                      Center(
                        child: AppText.bodySmall(context,
                            'Autenticação: ${DateTime.now().millisecondsSinceEpoch}',
                            color: Colors.grey.shade400),
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
                  color: Colors.black.withValues(alpha: 0.05),
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

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
