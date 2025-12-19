import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/completeProfile/controller/redirect_complete_profile_controller.dart';
import 'package:app_flutter_miban4/features/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
        () => ProfileController(Get.find<RedirectCompleteProfileController>()));

    AppLogger.I().debug('Profile dependencies injected');
  }
}
