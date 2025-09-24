
import 'package:app_flutter_miban4/data/api/services/services_repository.dart';
import 'package:get/get.dart';

class ServicesController extends GetxController {
  var isLoading = false.obs;
  var service = Rxn<dynamic>();

  @override
  void onInit() {
    super.onInit();
    services();
  }

  Future<void> services() async {
    isLoading(true);
    try {
      final response = await fetchServices();

      service.value = response;
    } catch (error) {
      throw Exception('Failed to load services: $error');
    } finally {
      isLoading(false);
    }
  }
}