import 'package:app_flutter_miban4/data/api/paymentLink/createPaymentLink.dart';
import 'package:app_flutter_miban4/data/model/payment/payment_link_entity.dart';
import 'package:app_flutter_miban4/ui/screens/home/paymentLink/paymentLink.dart';

import 'package:get/get.dart';

class PaymentValueController extends GetxController {
  var isLoading = false.obs;

  Future<void> createLink(String amount) async {
    isLoading(true);

    try {
      final PaymentLinkEntity response = await createPaymentLink(amount);

      if (response.success == true) {
        isLoading(false);
        Get.to(() => PaymentLink(payment: response,), transition: Transition.rightToLeft);
      } else {
        throw Exception("Erro na chamada de API: ${response.toString()}");
      }
    } catch (error) {
      isLoading(false);
    }
  }
}
