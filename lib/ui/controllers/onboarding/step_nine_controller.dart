import 'dart:io';

import 'package:app_flutter_miban4/data/api/onboarding/sendSelfie.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_selfie_confirm_page.dart';
import 'package:get/get.dart';

class StepNineController extends GetxController {
  var isLoading = false.obs;

  Future<bool> stepNine(File image) async {
    isLoading(true);

    try {
      await sendSelfie(image).then((result) {
        if (result['document_type'] == 'selfie') {
          Get.to(() => OnboardingSelfieConfirmPage(result: result),
              transition: Transition.rightToLeft);
        }
        return;
      });
      return true;
    } catch (e) {
      isLoading(false);
      return false;
    } finally {
      isLoading(false);
      image.deleteSync();
    }
  }
}
