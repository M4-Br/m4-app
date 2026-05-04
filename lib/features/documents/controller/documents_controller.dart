import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:get/get.dart';

class DocumentsController extends BaseController {
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Preparado para carregar documentos futuramente
  }
}
