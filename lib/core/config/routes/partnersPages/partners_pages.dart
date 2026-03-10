import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/partners/bindings/partner_management_binding.dart';
import 'package:app_flutter_miban4/features/partners/bindings/partner_new_item_bindings.dart';
import 'package:app_flutter_miban4/features/partners/bindings/partner_purchase_binding.dart';
import 'package:app_flutter_miban4/features/partners/bindings/partner_receipt_binding.dart';
import 'package:app_flutter_miban4/features/partners/bindings/partner_sales_history_binding.dart';
import 'package:app_flutter_miban4/features/partners/bindings/partners_binding.dart';
import 'package:app_flutter_miban4/features/partners/presentation/partner_management_page.dart';
import 'package:app_flutter_miban4/features/partners/presentation/partner_new_item_page.dart';
import 'package:app_flutter_miban4/features/partners/presentation/partner_purchase_page.dart';
import 'package:app_flutter_miban4/features/partners/presentation/partner_receipt_page.dart';
import 'package:app_flutter_miban4/features/partners/presentation/partner_sale_history_page.dart';
import 'package:app_flutter_miban4/features/partners/presentation/partners_page.dart';
import 'package:get/get.dart';

class PartnersPages {
  static List<GetPage> pages = [
    GetPage(
        name: AppRoutes.partners,
        page: () => const PartnersPage(),
        binding: PartnersBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.partnerPurchase,
        page: () => const PartnerPurchasePage(),
        binding: PartnerPurchaseBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.partnerReceipt,
        page: () => PartnerReceiptPage(),
        binding: PartnerReceiptBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.partnerManagement,
        page: () => PartnerManagementPage(),
        binding: PartnerManagementBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.partnerNewItem,
        page: () => PartnerNewItemPage(),
        binding: PartnerNewItemBindings(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.partnerSaleHistory,
        page: () => PartnerSaleHistoryPage(),
        binding: PartnerSalesHistoryBinding(),
        middlewares: [AuthGuard()]),
  ];
}
