import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class CompleteProfileReviewController extends BaseController {
  void goToHome() {
    if (Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().fetchSteps();
    }

    Get.until((route) => route.settings.name == AppRoutes.homeView);
  }

  Future<void> openMoreInfo() async {
    ShowToaster.toasterInfo(message: 'Em breve');
  }
}
