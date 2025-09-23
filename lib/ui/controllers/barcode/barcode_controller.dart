
import 'package:app_flutter_miban4/data/api/balance/balanceAPI.dart';
import 'package:app_flutter_miban4/data/api/barcode/decodeBarcode.dart';
import 'package:app_flutter_miban4/data/model/barcode/decodeBarcode.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/ui/screens/home/barcodePayment/barcodeConfirmPayment.dart';
import 'package:get/get.dart';

class BarcodeController extends GetxController {
  var isLoading = false.obs;
  Balance? balance;

  Future<void> barcodeDecode(String barcode) async {
    isLoading(true);
    try {
      Balance balance = await getBalance();
      PaymentData paymentData = await decodeBarcode(barcode);
      Get.off(
              () =>
              BarcodeConfirmPayment(paymentData: paymentData, balance: balance),
          transition: Transition.rightToLeft);
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }
}