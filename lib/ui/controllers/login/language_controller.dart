import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  Rx<String?> lang = ''.obs;

  void changeLanguage(String languageCode) {
    lang.value = languageCode;
    Get.updateLocale(Locale(languageCode));
    final box = GetStorage();
    box.write('language', languageCode);
  }

  @override
  void onInit() {
    super.onInit();
    final box = GetStorage();
    String? savedLanguage = box.read('language');
    lang.value = savedLanguage ?? Get.deviceLocale?.languageCode;
  }

  String getLanguageFlag(String languageCode) {
    switch (languageCode) {
      case 'pt_BR':
        return 'assets/icons/ic_flag_pt.png';
      case 'en':
        return 'assets/icons/ic_flag_en.png';
      case 'es':
        return 'assets/icons/ic_flag_es.png';
      default:
        return 'assets/icons/ic_flag_pt.png';
    }
  }
}
