import 'package:app_flutter_miban4/core/config/language/controller/change_language_controller.dart';
import 'package:app_flutter_miban4/core/config/language/controller/language_controller.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:get/get.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    AppLogger.I().info('Language Bindings injecteds');

    Get.lazyPut<LanguageController>(() => LanguageController(), fenix: true);

    Get.lazyPut<ChangeLanguageController>(
      () => ChangeLanguageController(
          languageController: Get.find<LanguageController>()),
    );
  }
}
