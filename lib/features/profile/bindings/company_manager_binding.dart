import 'package:app_flutter_miban4/features/profile/controller/company_manager_controller.dart';
import 'package:get/get.dart';

class CompanyManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyManagerController>(() => CompanyManagerController());
  }
}
