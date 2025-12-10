import 'package:app_flutter_miban4/features/web/controller/web_view_controller.dart';
import 'package:get/get.dart';

class WebViewBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebviewController>(() => WebviewController());
  }
}
