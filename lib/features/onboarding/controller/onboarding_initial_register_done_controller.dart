import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:get/get.dart';

class OnboardingInitialRegisterDoneController extends GetxController {
  final RxString document = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      document.value = arguments['document'] as String;
    }
  }

  void proccedToLogin() {
    Get.offAllNamed(AppRoutes.login, arguments: {'document': document});
  }
}
