import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/home/model/home_icons_response.dart';
import 'package:app_flutter_miban4/features/home/repository/fetch_icons_repository.dart';
import 'package:app_flutter_miban4/features/notifications/controller/notifications_controller.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:get/get.dart';

class HomeIconsController extends GetxController {
  final NotificationsController notifications;
  HomeIconsController({required this.notifications});
  RxList<HomeIconsResponse> icons = <HomeIconsResponse>[].obs;
  var isLoading = false.obs;
  var hasLoadedIcons = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchIcons();
  }

  Future<void> fetchIcons() async {
    if (hasLoadedIcons.value) return;

    try {
      isLoading(true);

      final fetchedIcons = await FetchIconsRepository().fetchIcons();

      if (fetchedIcons.isEmpty) {
        AppLogger.I().debug('No icons found');
        return;
      }

      AppLogger.I().debug('Icons fetched successfully');

      icons.assignAll(fetchedIcons);

      AppLogger.I().info('Icons list updated with ${icons.length} items');
      hasLoadedIcons.value = true;
    } on UnauthorizedException catch (e) {
      ShowToaster.toasterInfo(message: e.message);
      rethrow;
    } on ApiException catch (e) {
      ShowToaster.toasterInfo(message: e.message);
      rethrow;
    } catch (e, s) {
      AppLogger.I().error('Fetch Icons', e, s);
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
