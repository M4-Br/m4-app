import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/home/controller/home_controller.dart';
import 'package:app_flutter_miban4/features/home/controller/home_icons_controller.dart';
import 'package:app_flutter_miban4/features/notifications/controller/notifications_controller.dart';
import 'package:get/get.dart';

class HomeViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationsController>(() => NotificationsController(),
        fenix: true);

    Get.lazyPut<HomeIconsController>(() => HomeIconsController(
        notifications: Get.find<NotificationsController>()));

    Get.lazyPut<HomeViewController>(() => HomeViewController());

    AppLogger.I().debug('Home depencies injected');
  }
}
