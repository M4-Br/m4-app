import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_bank_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_confirm_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_contact_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_new_contact_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_success_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_value_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_voucher_page.dart';
import 'package:get/get.dart';

class TransferPages {
  static List<GetPage> transferPages = [
    //Transfer Contact
    GetPage(
        name: AppRoutes.transferContact,
        page: () => const TransferContactPage()),

    //Transfer New Contact
    GetPage(
        name: AppRoutes.transferNewContact,
        page: () => const TransferNewContactPage()),

    //Transfer Bank
    GetPage(name: AppRoutes.transferBank, page: () => const TransferBankPage()),

    //Transfer Value
    GetPage(
        name: AppRoutes.transferValue, page: () => const TransferValuePage()),

    //Transfer Confirm
    GetPage(
        name: AppRoutes.transferConfirm,
        page: () => const TransferConfirmPage()),

    //Transfer Success
    GetPage(
        name: AppRoutes.transferSuccess,
        page: () => const TransferSuccessPage()),

    //Transfer Voucher
    GetPage(
        name: AppRoutes.transferVoucher,
        page: () => const TransferVoucherPage()),
  ];
}
