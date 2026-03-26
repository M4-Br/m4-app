import 'package:app_flutter_miban4/features/favorites/controller/favorites_controller.dart';
import 'package:get/get.dart';

class FavoritesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritesController>(() => FavoritesController());
  }
}
