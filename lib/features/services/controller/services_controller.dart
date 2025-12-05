import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/services/model/services_response.dart';
import 'package:app_flutter_miban4/features/services/repository/services_repository.dart';
import 'package:get/get.dart';

class ServicesController extends BaseController {
  final Rx<ServicesResponse?> serviceResponse = Rx<ServicesResponse?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  Future<void> fetchServices() async {
    await executeSafe(() async {
      final result = await ServicesRepository().fetchServices();

      if (result.success == true) {
        serviceResponse.value = result;
      }
    });
  }
}
