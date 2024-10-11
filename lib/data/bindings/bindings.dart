import 'package:app_flutter_miban4/ui/controllers/home/home_controller.dart';
import 'package:app_flutter_miban4/ui/controllers/login/user_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(UserController());
    Get.put<HomeController>(HomeController());
  }
}