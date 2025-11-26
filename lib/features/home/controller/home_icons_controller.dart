import 'package:app_flutter_miban4/core/config/log/logger.dart';

import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_controller.dart';
import 'package:app_flutter_miban4/features/home/model/home_icons_response.dart';
import 'package:app_flutter_miban4/features/home/repository/fetch_icons_repository.dart';
import 'package:app_flutter_miban4/features/notifications/controller/notifications_controller.dart';
import 'package:get/get.dart';

class HomeIconsController extends BaseController {
  final NotificationsController notifications;
  final BalanceController balance;
  HomeIconsController({required this.notifications, required this.balance});

  RxList<HomeIconsResponse> icons = <HomeIconsResponse>[].obs;
  var hasLoadedIcons = false.obs;

  final RxBool incomplete = false.obs;

  @override
  void onInit() {
    super.onInit();
    registerIncomplete();
    fetchIcons();
  }

  void registerIncomplete() {
    if (userRx.user.value!.payload.aliasAccount?.accountId == null) {
      incomplete.value = true;
    }
  }

  Future<void> fetchIcons() async {
    if (hasLoadedIcons.value) return;

    await executeSafe(() async {
      final fetchedIcons = await FetchIconsRepository().fetchIcons();

      if (fetchedIcons.isEmpty) {
        AppLogger.I().debug('No icons found');
        return;
      }

      AppLogger.I().debug('Icons fetched successfully');
      icons.assignAll(fetchedIcons);
      AppLogger.I().info('Icons list updated with ${icons.length} items');
      hasLoadedIcons.value = true;
    }, message: 'Erro ao carregar os ícones');
  }
}
