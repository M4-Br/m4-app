import 'package:app_flutter_miban4/ui/routes/app_routes.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixAddKeys.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixAddValue.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixCodeDecode.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixCopyPaste.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixHome.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixKeyManager.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixManualKey.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixMyKeys.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixMyLimits.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixNewKey.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixQRCodeReceive.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixReceive.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixStatement.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixTransactionSuccess.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixTransfer.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixWithKey.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pix_voucher_screen.dart';
import 'package:get/get.dart';

class PixPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.pixHome, page: () => PixHome()),
    GetPage(name: AppRoutes.pixMyKeys, page: () => const PixMyKeys()),
    GetPage(name: AppRoutes.pixStatement, page: () => const PixStatementPage()),
    GetPage(name: AppRoutes.pixKeyManagement, page: () => const PixKeyManager()),
    GetPage(name: AppRoutes.pixAddKey, page: () => const PixAddKeys()),
    GetPage(name: AppRoutes.pixAddValue, page: () => PixAddValue()),
    GetPage(name: AppRoutes.pixDecode, page: () => PixCodeDecode()),
    GetPage(name: AppRoutes.pixCopyPaste, page: () => PixCopyPaste()),
    GetPage(name: AppRoutes.pixManualKey, page: () => const PixManualKey()),
    GetPage(name: AppRoutes.pixMyLimits, page: () => const PixMyLimits()),
    GetPage(name: AppRoutes.pixNewKey, page: () => PixNewKey()),
    GetPage(name: AppRoutes.pixQRReceive, page: () => PixQRCodeReceive()),
    GetPage(name: AppRoutes.pixReceive, page: () => const PixReceive()),
    GetPage(name: AppRoutes.pixSuccess, page: () => PixTransactionSuccess()),
    GetPage(name: AppRoutes.pixTransfer, page: () => PixTransfer()),
    GetPage(name: AppRoutes.pixWithKey, page: () => const PixWithKey()),
    GetPage(name: AppRoutes.pixInvoice, page: () => PixVoucher()),
  ];
}