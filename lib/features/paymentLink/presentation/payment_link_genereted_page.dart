import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/paymentLink/controller/payment_link_generated_controller.dart';

class PaymentLinkGeneretedPage extends GetView<PaymentLinkGeneratedController> {
  const PaymentLinkGeneretedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'demand_demand'.tr,
        showBackButton: true,
        backgroundColor: primaryColor,
        onBackPressed: controller.goBack,
      ),
      body: CustomPageBody(
        padding: const EdgeInsets.all(AppDimens.kPaddingXL),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: AppDimens.kPaddingL),
          AppText.headlineMedium(
            context,
            'payment_link_generated'.tr,
            color: Colors.white,
          ),
          gapXL,
          AppText.bodyLarge(
            context,
            'payment_link_receive'.tr.toUpperCase(),
            color: Colors.white,
          ),
          gap,
          Obx(
            () => AppText.bodyMedium(
              context,
              controller.formattedValue,
              color: secondaryColor,
            ),
          ),
          gap,
          AppText.bodyMedium(
            context,
            controller.currentDate,
            color: Colors.grey,
          ),
          gapXL,
          AppText.bodyMedium(
            context,
            'payment_link_share'.tr,
            color: Colors.grey,
          ),
          gapM,
          SizedBox(
            height: 45,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: controller.shareLink,
              icon: const Icon(
                Icons.share,
                color: Colors.black,
              ),
              label: Text(
                'payment_link_share_link'.tr.toUpperCase(),
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 0,
                side: const BorderSide(color: Colors.black, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.kPaddingXL),
        ],
      ),
    );
  }
}
