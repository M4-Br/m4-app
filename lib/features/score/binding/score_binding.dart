import 'package:app_flutter_miban4/features/score/controller/score_controller.dart';
import 'package:get/get.dart';

class ScoreBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScoreController>(() => ScoreController());
  }
}
