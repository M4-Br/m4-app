import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/bindings/barcode_confirm_payment_bindings.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/bindings/barcode_manual_bindings.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/bindings/barcode_voucher_bindings.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/presentation/barcode_confirm_payment_page.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/presentation/barcode_manual_page.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/presentation/barcode_voucher_page.dart';
import 'package:get/get.dart';

class BarcodePages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.barcodeManual,
        page: () => const BarcodeManualInputPage(),
        binding: BarcodeManualBindings()),
    GetPage(
        name: AppRoutes.barcodeConfirmPayment,
        page: () => const BarcodeConfirmPaymentPage(),
        binding: BarcodeConfirmPaymentBindings()),
    GetPage(
        name: AppRoutes.barcodeVoucher,
        page: () => const BarcodeVoucherPage(),
        binding: BarcodeVoucherBindings())
  ];
}
