import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/currency_formatter.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/bottom_button.dart';
import 'package:app_flutter_miban4/features/paymentLink/controller/payment_link_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';

class PaymentLinkPage extends GetView<PaymentLinkController> {
  const PaymentLinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: CustomAppBar(
        title: 'demand_demand'.tr,
        showBackButton: true,
        backgroundColor: primaryColor,
      ),
      body: CustomPageBody(
        children: [
          const SizedBox(height: 32),
          AppText.headlineMedium(
            context,
            'demand_value'.tr,
            color: Colors.white,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Obx(
              () => TextField(
                controller: controller.moneyController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                cursorColor: Colors.white,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: controller.isButtonEnabled.value
                      ? secondaryColor
                      : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
                decoration: const InputDecoration(
                  hintText: 'R\$ 0,00',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyFormatter(),
                ],
                onChanged: controller.onValueChanged,
              ),
            ),
          ),
          const Spacer(),
          Column(
            children: [
              AppText.bodyLarge(
                context,
                'demand_minimum'.tr,
                color: Colors.white,
              ),
              gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.bodyMedium(
                    context,
                    'demand_fees'.tr,
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.info_outline_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    splashRadius: 20,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
          Obx(
            () => bottomButton(
                onPressed: () => controller.createLink(),
                labelText: 'proceed'.tr,
                isLoading: controller.isLoading.value,
                enable: controller.isButtonEnabled.value),
          ),
        ],
      ),
    );
  }
}
