import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/marketplace/bindings/partner_management_binding.dart';
import 'package:app_flutter_miban4/features/marketplace/bindings/partner_new_item_bindings.dart';
import 'package:app_flutter_miban4/features/marketplace/bindings/partner_purchase_binding.dart';
import 'package:app_flutter_miban4/features/marketplace/bindings/partner_receipt_binding.dart';
import 'package:app_flutter_miban4/features/marketplace/bindings/partner_sales_history_binding.dart';
import 'package:app_flutter_miban4/features/marketplace/presentation/marketplace_management_page.dart';
import 'package:app_flutter_miban4/features/marketplace/presentation/marketplace_new_item_page.dart';
import 'package:app_flutter_miban4/features/marketplace/presentation/marketplace_purchase_page.dart';
import 'package:app_flutter_miban4/features/marketplace/presentation/marketplace_receipt_page.dart';
import 'package:app_flutter_miban4/features/marketplace/presentation/marketplace_sale_history_page.dart';
import 'package:get/get.dart';

class MarketplacePages {
  static List<GetPage> pages = [
    GetPage(
        name: AppRoutes.marketplacePurchase,
        page: () => const MarketplacePurchasePage(),
        binding: MarketplacePurchaseBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.marketplaceReceipt,
        page: () => MarketplaceReceiptPage(),
        binding: MarketplaceReceiptBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.marketplaceManagement,
        page: () => MarketplaceManagementPage(),
        binding: MarketplaceManagementBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.marketplaceNewItem,
        page: () => MarketplaceNewItemPage(),
        binding: MarketplaceNewItemBindings(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.marketplacealeHistory,
        page: () => MarketplaceSaleHistoryPage(),
        binding: MarketplaceSalesHistoryBinding(),
        middlewares: [AuthGuard()]),
  ];
}
