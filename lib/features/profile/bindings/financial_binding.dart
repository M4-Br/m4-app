import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/profile/controller/financial_controller.dart';
import 'package:get/get.dart';

class FinancialParamsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinancialController>(() => FinancialController());

    AppLogger.I().debug('Profile financial data dependencies injected');
  }
}
