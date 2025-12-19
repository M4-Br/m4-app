import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_document_choose.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileDocumentChoosePage
    extends GetView<CompleteProfileDocumentChooseController> {
  const CompleteProfileDocumentChoosePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '',
        backgroundColor: Colors.white,
        iconColor: Colors.black,
        onBackPressed: () =>
            Get.until((route) => route.settings.name == AppRoutes.homeView),
      ),
      body: CustomPageBody(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: AppText.headlineSmall(
              context,
              'choose_document'.tr,
              color: Colors.black54,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: Get.height * 0.15),
          Obx(() => RadioGroup<String>(
                groupValue: controller.selectedDocument.value,
                onChanged: (value) {
                  if (value != null) controller.selectDocument(value);
                },
                child: Column(
                  children: [
                    const Divider(height: 1, color: Colors.black38),
                    RadioListTile<String>(
                      title: AppText.bodyLarge(context, 'RG', bold: true),
                      value: 'rg',
                      activeColor: secondaryColor,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const Divider(height: 1, color: Colors.black38),
                    RadioListTile<String>(
                      title: AppText.bodyLarge(context, 'CNH', bold: true),
                      value: 'cnh',
                      activeColor: secondaryColor,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const Divider(height: 1, color: Colors.black38),
                  ],
                ),
              )),
          const Spacer(),
          AppButton(
            labelText: 'next'.tr,
            buttonType: AppButtonType.filled,
            color: secondaryColor,
            onPressed: () async => controller.nextStep(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
