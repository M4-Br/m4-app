import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/paymentLink/bindings/payment_link_bindings.dart';
import 'package:app_flutter_miban4/features/paymentLink/bindings/payment_link_generated_bindings.dart';
import 'package:app_flutter_miban4/features/paymentLink/presentation/payment_link_genereted_page.dart';
import 'package:app_flutter_miban4/features/paymentLink/presentation/payment_link_page.dart';
import 'package:get/get.dart';

class PaymentLinkPages {
  static List<GetPage> paymentLinkPages = [
    GetPage(
        name: AppRoutes.paymentLink,
        page: () => const PaymentLinkPage(),
        binding: PaymentLinkBindings(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.paymentLinkGenerated,
        page: () => const PaymentLinkGeneretedPage(),
        binding: PaymentLinkGeneratedBindings(),
        middlewares: [AuthGuard()]),
  ];
}
