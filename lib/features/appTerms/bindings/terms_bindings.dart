import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/appTerms/controller/terms_controller.dart';
import 'package:get/get.dart';

class TermsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsController>(() => TermsController());

    AppLogger.I().info('Terms dependencies injected');
  }
}
