import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:get/get.dart';

class CompleteProfileReviewController extends BaseController {
  void goToHome() {
    Get.until((route) => route.settings.name == AppRoutes.homeView);
  }

  Future<void> openMoreInfo() async {
    ShowToaster.toasterInfo(message: 'Em breve');
  }
}
