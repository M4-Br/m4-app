import 'package:app_flutter_miban4/features/offers/controller/offers_controller.dart';
import 'package:get/get.dart';

class OffersBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OffersController>(() => OffersController());
  }
}
