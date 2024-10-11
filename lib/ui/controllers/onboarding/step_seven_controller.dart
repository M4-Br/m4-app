
import 'dart:io';

import 'package:app_flutter_miban4/data/api/onboarding/sendPhoto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class StepSevenController extends GetxController {
  var isLoading = false.obs;

  Future<bool> stepSeven(String imageType, String document, File path) async {
    isLoading(true);

    try {
      Map<String, dynamic> response = await sendDocumentPhoto(imageType, document, path);

      if (response['steps'][5]['done'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      isLoading(false);
      throw Exception(error.toString());
    } finally {
      isLoading(false);
      path.deleteSync();
    }
  }
}