import 'package:app_flutter_miban4/data/api/pix/pixTransfer.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pix_voucher_screen.dart';
import 'package:get/get.dart';

class SendPixController extends GetxController {
  var isLoading = false.obs;

  Future<void> pixTransfer(
      String amount,
      String description,
      String id,
      String password,
      String idText,
      String accountNumber,
      String accountType,
      String branchNumber,
      String type,
      String document,
      String ispb,
      String name,
      String key,
      int transferType,
      String institute) async {
    isLoading(true);

    try {
      Map<String, dynamic> pixSend = await sendPixTransfer(
          amount,
          description,
          id,
          password,
          idText,
          accountNumber,
          accountType,
          branchNumber,
          type,
          document,
          ispb,
          name,
          key,
          transferType);

      if (pixSend['success'] == true) {
        Get.off(
            () => PixVoucher(
                  transfer: pixSend,
                  amount: amount,
                  name: name,
                  institute: institute,
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
