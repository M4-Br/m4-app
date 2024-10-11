
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:get/get.dart';


class BalanceController extends GetxController {
  Rx<Balance?> balanceData = Rx<Balance?>(null);

  void setBalance(Rx<Balance?> balance) {
    balanceData.value = balance.value;
  }
}