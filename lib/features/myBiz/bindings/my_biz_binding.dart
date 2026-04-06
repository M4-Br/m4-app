import 'package:app_flutter_miban4/features/myBiz/controller/my_biz_controller.dart';
import 'package:get/get.dart';

class MyBizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyBizController>(() => MyBizController());
  }
}
