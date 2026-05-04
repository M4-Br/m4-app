import 'package:app_flutter_miban4/features/documents/controller/documents_controller.dart';
import 'package:get/get.dart';

class DocumentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentsController>(() => DocumentsController());
  }
}
