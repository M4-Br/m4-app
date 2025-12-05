import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/pix/copyPaste/bindings/pix_copy_paste_bindings.dart';
import 'package:app_flutter_miban4/features/pix/copyPaste/presentation/pix_copy_paste_page.dart';
import 'package:app_flutter_miban4/features/pix/decode/bindings/pix_code_decode_bindings.dart';
import 'package:app_flutter_miban4/features/pix/decode/presentation/pix_code_decode_page.dart';
import 'package:app_flutter_miban4/features/pix/home/bindings/pix_home_bindings.dart';
import 'package:app_flutter_miban4/features/pix/home/presentation/pix_home_page.dart';
import 'package:app_flutter_miban4/features/pix/keyManager/bindings/pix_add_new_key_bindings.dart';
import 'package:app_flutter_miban4/features/pix/keyManager/bindings/pix_key_manager_bindings.dart';
import 'package:app_flutter_miban4/features/pix/keyManager/presentation/pix_add_new_key_page.dart';
import 'package:app_flutter_miban4/features/pix/keyManager/presentation/pix_key_manager_page.dart';
import 'package:app_flutter_miban4/features/pix/limits/bindings/pix_limits_bindings.dart';
import 'package:app_flutter_miban4/features/pix/limits/presentation/pix_limits_page.dart';
import 'package:app_flutter_miban4/features/pix/pixWithKey/bindings/pix_with_key_bindings.dart';
import 'package:app_flutter_miban4/features/pix/pixWithKey/presentation/pix_with_key_page.dart';
import 'package:app_flutter_miban4/features/pix/receive/bindings/pix_receive_bindings.dart';
import 'package:app_flutter_miban4/features/pix/receive/bindings/pix_receive_qr_code_bindings.dart';
import 'package:app_flutter_miban4/features/pix/receive/presentation/pix_receive_page.dart';
import 'package:app_flutter_miban4/features/pix/receive/presentation/pix_receive_qr_code_page.dart';
import 'package:app_flutter_miban4/features/pix/scheduled/bindings/pix_schedule_bindings.dart';
import 'package:app_flutter_miban4/features/pix/scheduled/presentation/pix_schedule_page.dart';
import 'package:app_flutter_miban4/features/pix/statement/bindings/pix_statement_bindings.dart';
import 'package:app_flutter_miban4/features/pix/statement/presentation/pix_statement_page.dart';
import 'package:app_flutter_miban4/features/pix/transfer/bindings/pix_transfer_binding.dart';
import 'package:app_flutter_miban4/features/pix/transfer/presentation/pix_transfer_page.dart';
import 'package:app_flutter_miban4/features/pix/voucher/bindings/pix_voucher_bindings.dart';
import 'package:app_flutter_miban4/features/pix/voucher/presentation/pix_voucher_page.dart';
import 'package:get/get.dart';

class PixPages {
  static final List<GetPage> pages = [
    //Home
    GetPage(
      name: AppRoutes.pixHome,
      page: () => const PixHomePage(),
      binding: PixHomeBindings(),
    ),

    //Key Manager
    GetPage(
      name: AppRoutes.pixKeyManager,
      page: () => const PixKeyManagerPage(),
      binding: PixKeyManagerBindings(),
    ),

    //Limits
    GetPage(
      name: AppRoutes.pixLimits,
      page: () => const PixLimitsPage(),
      binding: PixMyLimitsBindings(),
    ),

    //Generate QR Code
    GetPage(
      name: AppRoutes.pixReceive,
      page: () => const PixReceivePage(),
      binding: PixReceiveBindings(),
    ),
    GetPage(
      name: AppRoutes.pixReceiveQrCode,
      page: () => const PixReceiveQrCodePage(),
      binding: PixReceiveQrCodeBindings(),
    ),

    //Send pix to key
    GetPage(
      name: AppRoutes.pixWithKey,
      page: () => const PixWithKeyPage(),
      binding: PixWithKeyBindings(),
    ),

    GetPage(
      name: AppRoutes.pixTransfer,
      page: () => const PixTransferPage(),
      binding: PixTransferBindings(),
    ),
    GetPage(
      name: AppRoutes.pixInvoice,
      page: () => const PixVoucherPage(),
      binding: PixVoucherBindings(),
    ),
    GetPage(
      name: AppRoutes.pixScheduled,
      page: () => const PixSchedulePage(),
      binding: PixScheduleBindings(),
    ),
    GetPage(
      name: AppRoutes.pixCopyPaste,
      page: () => const PixCopyPastePage(),
      binding: PixCopyPasteBindings(),
    ),
    GetPage(
        name: AppRoutes.pixDecode,
        page: () => const PixCodeDecodePage(),
        binding: PixCodeDecodeBindings()),
    GetPage(
      name: AppRoutes.pixNewKey,
      page: () => const PixAddNewKeyPage(),
      binding: PixAddNewKeyBindings(),
    ),
    GetPage(
        name: AppRoutes.pixStatement,
        page: () => const PixStatementPage(),
        binding: PixStatementBindings()),
  ];
}
