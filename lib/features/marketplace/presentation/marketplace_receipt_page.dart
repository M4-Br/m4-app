import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/marketplace/controller/marketplace_receipt_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketplaceReceiptPage extends GetView<MarketplaceReceiptController> {
  const MarketplaceReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    final valParceiro =
        'R\$ ${controller.item.marketplaceValue.toStringAsFixed(2).replaceAll('.', ',')}';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'COMPROVANTE',
        showBackButton: true,
        onBackPressed: controller.backToHome,
      ),
      body: CustomPageBody(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),
          const Icon(
            Icons.check_circle_outline,
            color: secondaryColor,
            size: 80,
          ),
          const SizedBox(height: 24),
          Center(
            child: AppText.titleLarge(
              context,
              'Compra realizada com sucesso!',
              color: Colors.black87,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
          _buildReceiptRow(context, 'Valor:', valParceiro, isBold: true),
          const SizedBox(height: 16),
          _buildReceiptRow(context, 'No dia:', controller.transactionDate),
          const SizedBox(height: 16),
          _buildReceiptRow(context, 'Para:', controller.item.name,
              isHighlight: true),
          const SizedBox(height: 16),
          _buildReceiptRow(context, 'Operação:', controller.operationId),
          const SizedBox(height: 16),
          _buildReceiptRow(context, 'Taxas:', 'R\$ 0,00'),
          const Spacer(),
          AppButton(
            labelText: 'COMPARTILHAR',
            buttonType: AppButtonType.outlined,
            onPressed: () async => controller.shareReceipt(),
          ),
          const SizedBox(height: 16),
          AppButton(
            labelText: 'VOLTAR AO INÍCIO',
            buttonType: AppButtonType.filled,
            onPressed: () async => controller.backToHome(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildReceiptRow(BuildContext context, String label, String value,
      {bool isBold = false, bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.bodyLarge(context, label, color: Colors.black54),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isHighlight ? secondaryColor : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
