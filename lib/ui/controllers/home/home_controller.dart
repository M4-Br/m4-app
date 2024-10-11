
import 'package:app_flutter_miban4/data/api/home/home_icons.dart';
import 'package:app_flutter_miban4/data/model/home/home.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<dynamic> icons = [].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  var hasLoadedIcons = false.obs;

  Future<void> getIcons() async {
    if (hasLoadedIcons.value) {
      return;
    }

    isLoading(true);

    try {
      final List<IconModel> loadedIcons = await homeIcons();
      icons.assignAll(loadedIcons);
      hasLoadedIcons.value = true;
    } catch (e) {
      error("Erro ao chamar API");
    } finally {
      isLoading(false);
    }
  }
}
