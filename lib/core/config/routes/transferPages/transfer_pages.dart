import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/TED/bindings/transfer_bank_choose_bindings.dart';
import 'package:app_flutter_miban4/features/TED/bindings/transfer_contacts_bindings.dart';
import 'package:app_flutter_miban4/features/TED/bindings/transfer_new_contact_bindings.dart';
import 'package:app_flutter_miban4/features/TED/bindings/transfer_success_bindings.dart';
import 'package:app_flutter_miban4/features/TED/bindings/transfer_value_bindings.dart';
import 'package:app_flutter_miban4/features/TED/bindings/transfer_voucher_bindings.dart';
import 'package:app_flutter_miban4/features/TED/presentation/transfer_bank_choose_page.dart';
import 'package:app_flutter_miban4/features/TED/presentation/transfer_contacts_page.dart';
import 'package:app_flutter_miban4/features/TED/presentation/transfer_new_contact_page.dart';
import 'package:app_flutter_miban4/features/TED/presentation/transfer_success_page.dart';
import 'package:app_flutter_miban4/features/TED/presentation/transfer_value_page.dart';
import 'package:app_flutter_miban4/features/TED/presentation/transfer_voucher_page.dart';
import 'package:get/get.dart';

class TransferPages {
  static List<GetPage> transferPages = [
    //Transfer Contact
    GetPage(
        name: AppRoutes.transfer,
        page: () => const TransferContactsPage(),
        binding: TransferContactsBindings(),
        middlewares: [AuthGuard()]),

    //Transfer New Contact
    GetPage(
        name: AppRoutes.transferNewContact,
        page: () => const TransferNewContactPage(),
        binding: TransferNewContactBindings(),
        middlewares: [AuthGuard()]),

    //Transfer Bank
    GetPage(
        name: AppRoutes.transferBank,
        page: () => const TransferBankPage(),
        binding: TransferBankChooseBindings(),
        middlewares: [AuthGuard()]),

    //Transfer Value
    GetPage(
        name: AppRoutes.transferValueAndConfirm,
        page: () => const TransferValuePage(),
        binding: TransferValueBindings(),
        middlewares: [AuthGuard()]),

    //Transfer Success
    GetPage(
        name: AppRoutes.transferSuccess,
        page: () => const TransferSuccessPage(),
        binding: TransferSuccessBindings(),
        middlewares: [AuthGuard()]),

    //Transfer Voucher
    GetPage(
        name: AppRoutes.transferVoucher,
        page: () => const TransferVoucherPage(),
        binding: TransferVoucherBindings(),
        middlewares: [AuthGuard()]),
  ];
}
