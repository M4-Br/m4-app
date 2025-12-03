import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/currency_formatter.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/pix/transfer/controller/pix_transfer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PixTransferPage extends GetView<PixTransferController> {
  const PixTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'pix_withKey'.tr,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Text(
              'pix_payValue'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 36),
              child: TextField(
                controller: controller.amountController,
                style: const TextStyle(
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'R\$ 0,00',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyFormatter(),
                ],
                keyboardType: TextInputType.number,
              ),
            ),

            TextField(
              controller: controller.descriptionController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.edit, color: Colors.black),
                hintText: 'pix_descriptionTransfer'.tr,
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),

            // Seletor de Data
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Text('pix_transferDate'.tr,
                      style: const TextStyle(fontSize: 16)),
                  const Spacer(),
                  InkWell(
                    onTap: () => controller.pickDate(context),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 8.0),
                        Obx(() => Text(
                              controller.formattedDate,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Divider(color: Colors.black),

            _buildInfoRow('pix_keyKey'.tr, controller.pixData.key),

            _buildInfoRow(
                'pix_receiverTransfer'.tr, controller.formattedReceiverName),

            _buildInfoRow('CPF/CNPJ', controller.formattedReceiverDoc),

            _buildInfoRow('pix_institution'.tr, controller.pixData.bankName),

            SizedBox(height: MediaQuery.of(context).size.height / 7),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Obx(() => Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "${'balance_available'.tr}: "),
                        TextSpan(
                          text: controller.balanceRx.balance.value!.balanceCents
                              .toBRL(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                      style: const TextStyle(fontSize: 16),
                    ),
                  )),
            ),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () => Get.back(),
                      child: Text('cancel'.tr.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: Obx(() => controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                                color: secondaryColor))
                        : ElevatedButton(
                            onPressed: () =>
                                controller.showConfirmationDialog(),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: secondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: Text('pay'.tr,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Expanded(
            flex: 0,
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
