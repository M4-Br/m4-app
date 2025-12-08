import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/services/controller/services_controller.dart';

class ServicesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesController>(
      () => ServicesController(),
    );

    AppLogger.I().debug('Services dependencies injected');
  }
}
