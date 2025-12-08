import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/controller/barcode_manual_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BarcodeManualInputPage extends GetView<BarcodeManualInputController> {
  const BarcodeManualInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Digitar Código',
        onBackPressed: controller.back,
      ),
      body: CustomPageBody(
        padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
        children: [
          const SizedBox(height: 24),

          Center(
            child: AppText.titleMedium(
              context,
              'Insira o código de barras do boleto',
              textAlign: TextAlign.center,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 32),

          // Campo de Texto
          TextField(
            controller: controller.codeController,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 18, letterSpacing: 1.2),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
              labelText: 'Código de Barras',
              hintText: '00000.00000 00000.000000...',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor, width: 2),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            maxLines: 1,
          ),

          const SizedBox(height: 8),
          AppText.bodySmall(context, 'Digite apenas os números',
              color: Colors.grey),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  labelText: 'CANCELAR',
                  onPressed: () async => controller.back(),
                  buttonType: AppButtonType.filled,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Obx(() => AppButton(
                      labelText: 'CONTINUAR',
                      isLoading: controller.isLoading.value,
                      color: controller.buttonColor,
                      onPressed: () async => controller.isButtonEnabled.value
                          ? controller.processBarcode()
                          : null,
                    )),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
