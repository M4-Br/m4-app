import 'package:app_flutter_miban4/features/clients/controller/clients_controller.dart';
import 'package:get/get.dart';

class ClientsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientsController>(() => ClientsController());
  }
}
