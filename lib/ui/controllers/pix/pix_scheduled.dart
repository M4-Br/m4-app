import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/data/api/pix/pix_show_scheduled.dart';
import 'package:app_flutter_miban4/data/model/pix/pixScheduled.dart';
import 'package:get/get.dart';

class PixScheduledController extends GetxController {
  var isLoading = false.obs;
  var scheduledPixList = <PixScheduled>[].obs;
  var message = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchScheduledPix();
  }

  Future<void> fetchScheduledPix() async {
    isLoading(true);
    try {
      final response = await showScheduledPix();

      if (response.success) {
        scheduledPixList.value = response.data;
      } else {
        scheduledPixList.clear();
      }

    } catch (e, s) {
      AppLogger.I().error('Erro ao buscar PIX agendados', e, s);
      scheduledPixList.clear();
      message.value = 'Erro ao carregar PIX agendados';
    } finally {
      isLoading(false);
    }
  }
}
