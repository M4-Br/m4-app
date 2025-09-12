import 'package:app_flutter_miban4/data/api/balance/balanceAPI.dart';
import 'package:app_flutter_miban4/data/api/qrcode/decodeCode.dart';
import 'package:app_flutter_miban4/data/model/qrCode/decodeQRCode.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixAddValue.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixCodeDecode.dart';
import 'package:get/get.dart';

class QrcodeController extends GetxController {
  var isLoading = false.obs;
  Balance? balance;

  Future<void> scanQrCode(String qrCode) async {
    isLoading(true);
    try {
      balance = await getBalance();
      DecodeQRCode paymentData = await decodeCode(qrCode);

      if (paymentData.finalAmount != 0) {
        isLoading(false);
        Get.off(
            () => PixCodeDecode(
                  qrCode: paymentData,
                  balance: balance,
                ),
            transition: Transition.rightToLeft);
      } else {
        isLoading(false);
        Get.off(
            () => PixAddValue(
                  qrCode: paymentData,
                  balance: balance,
                ),
            transition: Transition.rightToLeft);
      }
    } catch (error) {
      isLoading(false);
      throw Exception(error.toString());
    }
  }

  Future<void> decodeCopyPaste(String content) async {
    isLoading(true);

    try {
      balance = await getBalance();
      DecodeQRCode paymentData = await decodeCode(content);

      if (paymentData.success == true) {
        isLoading(false);
        Get.to(
            () => PixCodeDecode(
                  qrCode: paymentData,
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

// TODO: SOLVE QR CODE SCANNER
