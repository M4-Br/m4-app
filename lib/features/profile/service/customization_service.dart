import 'package:app_flutter_miban4/core/helpers/utils/app_enums.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomizationService extends GetxService {
  static CustomizationService get to => Get.find();

  final _box = GetStorage();
  final _key = 'home_icon_style';

  final homeIconStyle = HomeIconStyle.standard.obs;

  Future<CustomizationService> init() async {
    final storedStyle = _box.read<int>(_key);
    if (storedStyle != null) {
      homeIconStyle.value = HomeIconStyle.values[storedStyle];
    }
    return this;
  }

  void updateHomeIconStyle(HomeIconStyle style) {
    homeIconStyle.value = style;
    _box.write(_key, style.index);
  }
}
