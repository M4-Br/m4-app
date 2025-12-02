import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/pix/home/bindings/pix_home_bindings.dart';
import 'package:app_flutter_miban4/features/pix/home/presentation/pix_home_page.dart';
import 'package:app_flutter_miban4/features/pix/keyManager/bindings/pix_key_manager_bindings.dart';
import 'package:app_flutter_miban4/features/pix/keyManager/presentation/pix_key_manager_page.dart';
import 'package:app_flutter_miban4/features/pix/limits/bindings/pix_limits_bindings.dart';
import 'package:app_flutter_miban4/features/pix/limits/presentation/pix_limits_page.dart';
import 'package:app_flutter_miban4/features/pix/receive/bindings/pix_receive_bindings.dart';
import 'package:app_flutter_miban4/features/pix/receive/bindings/pix_receive_qr_code_bindings.dart';
import 'package:app_flutter_miban4/features/pix/receive/presentation/pix_receive_page.dart';
import 'package:app_flutter_miban4/features/pix/receive/presentation/pix_receive_qr_code_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixAddKeys.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixAddValue.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixCodeDecode.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixCopyPaste.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixManualKey.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixMyKeys.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixNewKey.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixStatement.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixTransactionSuccess.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixTransfer.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixWithKey.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pix_voucher_screen.dart';
import 'package:get/get.dart';

class PixPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.pixHome,
      page: () => const PixHomePage(),
      binding: PixHomeBindings(),
    ),

    GetPage(
      name: AppRoutes.pixKeyManager,
      page: () => const PixKeyManagerPage(),
      binding: PixKeyManagerBindings(),
    ),
    GetPage(
      name: AppRoutes.pixLimits,
      page: () => const PixLimitsPage(),
      binding: PixMyLimitsBindings(),
    ),
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

    //Divisão
    GetPage(name: AppRoutes.pixMyKeys, page: () => const PixMyKeys()),
    GetPage(name: AppRoutes.pixStatement, page: () => const PixStatementPage()),
    GetPage(name: AppRoutes.pixAddKey, page: () => const PixAddKeys()),
    GetPage(name: AppRoutes.pixAddValue, page: () => PixAddValue()),
    GetPage(name: AppRoutes.pixDecode, page: () => PixCodeDecode()),
    GetPage(name: AppRoutes.pixCopyPaste, page: () => PixCopyPaste()),
    GetPage(name: AppRoutes.pixManualKey, page: () => const PixManualKey()),
    GetPage(name: AppRoutes.pixNewKey, page: () => PixNewKey()),
    GetPage(name: AppRoutes.pixSuccess, page: () => PixTransactionSuccess()),
    GetPage(name: AppRoutes.pixTransfer, page: () => PixTransfer()),
    GetPage(name: AppRoutes.pixWithKey, page: () => const PixWithKey()),
    GetPage(name: AppRoutes.pixInvoice, page: () => PixVoucher()),
  ];
}
