import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/profile/controller/plans_controller.dart';
import 'package:get/get.dart';

class PlansBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlansController>(() => PlansController());

    AppLogger.I().debug('Profile plans dependencies injected');
  }
}
