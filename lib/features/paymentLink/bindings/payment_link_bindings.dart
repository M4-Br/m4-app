import 'package:app_flutter_miban4/features/paymentLink/controller/payment_link_controller.dart';
import 'package:get/get.dart';

class PaymentLinkBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentLinkController>(() => PaymentLinkController());
  }
}
