import 'package:app_flutter_miban4/features/statements/controllers/statement_controller.dart';
import 'package:get/get.dart';

class StatementBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatementController>(() => StatementController());
  }
}
