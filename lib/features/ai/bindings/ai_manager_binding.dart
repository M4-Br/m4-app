import 'package:app_flutter_miban4/features/ai/controller/ai_manager_controller.dart';
import 'package:get/get.dart';

class AiManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AiManagerController>(() => AiManagerController());
  }
}
