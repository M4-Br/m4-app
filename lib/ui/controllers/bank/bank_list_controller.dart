import 'package:app_flutter_miban4/data/api/bank/get_bank.dart';
import 'package:app_flutter_miban4/data/model/bank/bank_entity.dart';
import 'package:get/get.dart';

class BankListController extends GetxController {
  var isLoading = false.obs;
  var bankList = <Bank>[].obs;

  Future<void> getBank() async {
    isLoading(true);

    try {
      final banks = await getBanks();
      bankList.value = banks;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
