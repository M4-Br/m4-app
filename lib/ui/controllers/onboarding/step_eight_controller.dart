
import 'dart:io';

import 'package:app_flutter_miban4/data/api/onboarding/sendDocumentSelfie.dart';
import 'package:get/get.dart';

class StepEightController extends GetxController {
  var isLoading = false.obs;

  Future<bool> stepEight(File image) async {
    isLoading(true);

    try {
      await sendDocumentSelfie(image);
      return true;
    } catch (error) {
      isLoading(false);
      return false;
    } finally {
      isLoading(false);
      image.deleteSync();
    }
  }
}