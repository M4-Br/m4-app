import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/TED/controller/transfer_new_contact_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_shifter_v2/mask_shifter.dart';

class TransferNewContactPage extends GetView<TransferNewContactController> {
  const TransferNewContactPage({super.key});

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
              'transfer_to'.tr,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 32),

          // Label
          Align(
            alignment: Alignment.centerLeft,
            child: AppText.bodyLarge(
              context,
              'transfer_cpf'.tr,
            ),
          ),

          const SizedBox(height: 8),

          // Input
          TextField(
            controller: controller.documentController,
            keyboardType: TextInputType.number,
            cursorColor: secondaryColor,
            style: const TextStyle(fontSize: 18),
            inputFormatters: [
              MaskedTextInputFormatterShifter(
                  maskONE: 'XXX.XXX.XXX-XX', maskTWO: 'XX.XXX.XXX/XXXX-XX')
            ],
            decoration: InputDecoration(
              hintText: '000.000.000-00',
              hintStyle: TextStyle(color: Colors.grey.shade400),
              border: const UnderlineInputBorder(),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: secondaryColor, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),

          const Spacer(),

          Obx(() => SizedBox(
                width: double.infinity,
                child: AppButton(
                  labelText: 'next'.tr.toUpperCase(),
                  isLoading: controller.isLoading.value,
                  color: secondaryColor,
                  onPressed: () => controller.onNext(),
                ),
              )),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
