import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:app_flutter_miban4/features/statements/controllers/statement_controller.dart';
import 'package:get/get.dart';

class StatementBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatementController>(
        () => StatementController(balance: Get.find<BalanceRx>()));

    AppLogger.I().debug('Statement dependencies injected');
  }
}
