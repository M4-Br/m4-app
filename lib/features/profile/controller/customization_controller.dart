import 'package:app_flutter_miban4/core/helpers/utils/app_enums.dart';
import 'package:app_flutter_miban4/features/profile/service/customization_service.dart';
import 'package:get/get.dart';

class CustomizationController extends GetxController {
  final CustomizationService _service = CustomizationService.to;

  HomeIconStyle get currentStyle => _service.homeIconStyle.value;

  void setHomeIconStyle(HomeIconStyle style) {
    _service.updateHomeIconStyle(style);
  }
}
