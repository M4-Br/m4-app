import 'package:app_flutter_miban4/core/config/language/controller/language_controller.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChangeLanguageController extends GetxController {
  final LanguageController languageController;
  ChangeLanguageController({required this.languageController});

  final box = GetStorage();

  void changeLanguage(String languageCode) {
    AppLogger.I().info('Changing language to $languageCode');
    languageController.lang.value = languageCode;
    Get.updateLocale(Locale(languageCode));
    AppLogger.I().debug('Language changed to $languageCode');
    final box = GetStorage();
    box.write('language', languageCode);
  }

  @override
  onInit() {
    super.onInit();
    String? savedLanguage = box.read('language');
    languageController.lang.value =
        savedLanguage ?? Get.deviceLocale?.languageCode;
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
