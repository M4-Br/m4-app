import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:app_flutter_miban4/features/pix/statement/controller/pix_statement_controller.dart';
import 'package:get/get.dart';

class PixStatementBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PixStatementController(balance: Get.find<BalanceRx>()));
  }
}
