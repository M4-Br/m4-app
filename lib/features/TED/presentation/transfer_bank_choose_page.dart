import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/TED/controller/transfer_bank_choose_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferBankPage extends GetView<TransferBankController> {
  const TransferBankPage({super.key});

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
          const SizedBox(height: 24),

          Center(
            child: AppText.titleLarge(
              context,
              controller.beneficiaryName,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 8),

          // CPF/CNPJ
          Center(
            child: AppText.bodyLarge(
              context,
              controller.formattedDocument,
              color: Colors.grey.shade700,
            ),
          ),

          const SizedBox(height: 32),

          ...[
            _buildOptionCard(
              context,
              icon: Icons.account_balance_outlined,
              title: 'transfer_miban'.tr,
              onTap: controller.goToTransferValue,
            ),
            const SizedBox(height: 16),
          ],

          _buildOptionCard(
            context,
            icon: Icons.account_balance_rounded,
            title: 'transfer_other'.tr,
            onTap: controller.goToOtherBank,
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Center(
                  child: CircularProgressIndicator(color: secondaryColor),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40.0, color: secondaryColor),
            const SizedBox(width: 16.0),
            Expanded(
              child: AppText.titleMedium(
                context,
                title,
                color: Colors.black87,
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
