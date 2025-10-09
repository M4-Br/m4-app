import 'package:app_flutter_miban4/features/balance/model/balance_response.dart';
import 'package:get/get.dart';

class BalanceRx extends GetxController {
  Rx<BalanceResponse?> balance = Rx<BalanceResponse?>(null);
}
