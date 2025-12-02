import 'package:app_flutter_miban4/data/api/balance/balanceAPI.dart';
import 'package:app_flutter_miban4/data/api/pix/pixValidateKey.dart';
import 'package:app_flutter_miban4/data/model/pix/pixValidateKey.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixTransfer.dart';
import 'package:get/get.dart';

class PixWithKeyController extends GetxController {
  var isLoading = false.obs;

  Future<void> searchKey(String key) async {
    isLoading(true);

    try {
      Balance balance = await getBalance();
      ValidateKey keyValidate = await validateKey(key);

      if (keyValidate.success == true) {
        Get.to(
            () => PixTransfer(
                  pix: keyValidate,
                  balance: balance,
                ),
            transition: Transition.rightToLeft);
      }
    } catch (error) {
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
