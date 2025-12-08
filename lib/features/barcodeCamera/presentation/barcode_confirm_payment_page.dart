import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/controller/barcode_confirm_payment_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BarcodeConfirmPaymentPage
    extends GetView<BarcodeConfirmPaymentController> {
  const BarcodeConfirmPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'pay'.tr,
        onBackPressed: () => controller.backToReader(),
      ),
      body: CustomPageBody(
        padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
        children: [
          const SizedBox(height: 24),

          Center(
            child: AppText.titleMedium(
              context,
              'payment_total'.tr,
              color: Colors.black87,
            ),
          ),

          // Valor em Destaque
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                controller.paymentData.amount.toBRL(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: secondaryColor,
                ),
              ),
            ],
          ),
          Center(
            child: Obx(() => Text(
                  "${'balance_available'.tr}: ${controller.formattedBalance}",
                  style: TextStyle(
                      color: controller.hasSufficientBalance
                          ? Colors.black87
                          : Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                )),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Divider(),
          ),

          // Detalhes do Pagamento
          _buildDetailRow('payment_realized'.tr, controller.todayFormatted,
              isHighlight: true),
          _buildDetailRow('payment_expired'.tr,
              controller.paymentData.dueDate.toVoucherFormat()),
          _buildDetailRow(
              'payment_receiver'.tr, controller.paymentData.assignor),
          _buildDetailRow(
              'payment_barcode'.tr, controller.paymentData.digitableLine,
              isBarcode: true),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(),
          ),

          _buildDetailRow('payment_discount'.tr,
              'R\$ ${controller.paymentData.details.discount}'),
          _buildDetailRow('payment_fees'.tr,
              'R\$ ${controller.paymentData.details.interest}'),
          _buildDetailRow(
              'payment_fine'.tr, 'R\$ ${controller.paymentData.details.fine}'),
          const Spacer(),
          Obx(() => SizedBox(
                width: double.infinity,
                child: AppButton(
                  labelText: 'pay_barcode'.tr.toUpperCase(),
                  isLoading: controller.isLoading.value,
                  color: secondaryColor,
                  // Desabilita se não tiver saldo
                  onPressed: () async => controller.hasSufficientBalance
                      ? controller.openPasswordDialog()
                      : null,
                ),
              )),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isHighlight = false, bool isBarcode = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              isBarcode && value.length > 15
                  ? '${value.substring(0, 15)}...'
                  : value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                color: isHighlight ? secondaryColor : Colors.black87,
                decoration: isHighlight
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
