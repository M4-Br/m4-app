import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:get/get.dart';

class HealthPlansController extends BaseController {
  void goToTerms(String planName) {
    Get.toNamed(AppRoutes.healthTerms, arguments: {'planName': planName});
  }
}
