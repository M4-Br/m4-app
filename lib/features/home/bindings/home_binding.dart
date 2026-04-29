import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/ai/bindings/ai_manager_binding.dart';
import 'package:app_flutter_miban4/features/ai/controller/ai_manager_controller.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_controller.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:app_flutter_miban4/features/geral/controller/favorites_transfers_controller.dart';
import 'package:app_flutter_miban4/features/home/controller/home_controller.dart';
import 'package:app_flutter_miban4/features/home/controller/home_icons_controller.dart';
import 'package:app_flutter_miban4/features/notifications/controller/notifications_controller.dart';
import 'package:app_flutter_miban4/features/profile/controller/plans_controller.dart';
import 'package:get/get.dart';

class HomeViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationsController>(() => NotificationsController());

    Get.put<BalanceController>(
        BalanceController(balanceRx: Get.find<BalanceRx>()));

    Get.lazyPut<FavoritesTransfersController>(
        () => FavoritesTransfersController(),
        fenix: true);

    Get.lazyPut<AiManagerController>(() => AiManagerController());

    Get.lazyPut<HomeIconsController>(() => HomeIconsController(
        notifications: Get.find<NotificationsController>(),
        balance: Get.find<BalanceController>()));

    Get.lazyPut<HomeViewController>(() => HomeViewController());

    // Get.lazyPut<StatementController>(
    //     () => StatementController(balance: Get.find<BalanceRx>()));

    Get.lazyPut<PlansController>(() => PlansController());

    AppLogger.I().debug('Home depencies injected');
  }
}
