// file: splash_binding.dart

import 'package:app_flutter_miban4/features/splash/controller/splash_screen_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
  }
}
