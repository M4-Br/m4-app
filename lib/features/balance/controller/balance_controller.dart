import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:app_flutter_miban4/features/balance/repository/balance_repository.dart';
import 'package:get/get_rx/get_rx.dart';

class BalanceController extends BaseController {
  final BalanceRx balanceRx;
  BalanceController({required this.balanceRx});

  var isVisible = false.obs;

  @override
  void onInit() {
    balanceDetails();
    super.onInit();
  }

  Future<void> balanceDetails() async {
    await executeSafe(() async {
      final balanceDetails = await BalanceRepository().fetchBalance();
      balanceRx.balance.value = balanceDetails;
      AppLogger.I().info('Balance received');
    }, message: 'Erro ao obter saldo do usuário');
  }

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }
}
