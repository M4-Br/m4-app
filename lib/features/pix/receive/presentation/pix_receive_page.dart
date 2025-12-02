import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/currency_formatter.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/pix/receive/controller/pix_receive_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PixReceivePage extends GetView<PixReceiveController> {
  const PixReceivePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'pix_receiver'.tr,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.availableKeys.isEmpty) {
          return const Center(
              child: CircularProgressIndicator(color: primaryColor));
        }

        return CustomPageBody(
          padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'pix_selectKey'.tr),
                        const TextSpan(text: ' '),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => controller.goToKeyManager(),
                          text: 'pix_nKey'.tr,
                          style: const TextStyle(
                              color: secondaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info_outline, size: 20),
                )
              ],
            ),
            gapXL,
            _buildDropdown(context),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('pix_optional'.tr, style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 4),
                const Icon(Icons.info_outline_rounded, size: 16),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.identifierController,
              style: const TextStyle(color: Colors.black, fontSize: 20),
              decoration: _inputDecoration(label: 'pix_identifier'.tr),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: controller.descriptionController,
              maxLength: 72,
              style: const TextStyle(color: Colors.black, fontSize: 20),
              decoration: _inputDecoration(
                  label: 'pix_description'.tr,
                  counterText: '72 caracteres disponíveis'),
            ),
            gapM,
            TextField(
              controller: controller.amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black, fontSize: 20),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyFormatter()
              ],
              decoration: _inputDecoration(label: 'pix_value'.tr),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(color: secondaryColor))
                    : ElevatedButton(
                        onPressed: controller.generateQrCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'next'.tr,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      }),
    );
  }

  Widget _buildDropdown(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: controller.selectedKey.value,
      isExpanded: true,
      hint: Text('pix_keySelect'.tr),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      onChanged: (String? newValue) {
        controller.selectedKey.value = newValue;
      },
      items: controller.availableKeys
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  InputDecoration _inputDecoration(
      {required String label, String? counterText}) {
    return InputDecoration(
      isDense: true,
      counterText: counterText,
      border: InputBorder.none,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black54),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black54),
      ),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black54, fontSize: 16),
    );
  }
}
