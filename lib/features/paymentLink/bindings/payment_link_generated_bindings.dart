import 'package:app_flutter_miban4/features/paymentLink/controller/payment_link_generated_controller.dart';
import 'package:get/get.dart';

class PaymentLinkGeneratedBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentLinkGeneratedController>(
        () => PaymentLinkGeneratedController());
  }
}
