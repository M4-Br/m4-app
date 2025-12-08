import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_controller.dart';
import 'package:app_flutter_miban4/features/home/model/home_icons_response.dart';
import 'package:app_flutter_miban4/features/home/repository/fetch_icons_repository.dart';
import 'package:app_flutter_miban4/features/notifications/controller/notifications_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/partners/webview_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_contact_page.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:get/get.dart';

class HomeMenuItem {
  final String id;
  final String title;
  final String iconPath;
  final bool isLocal;

  HomeMenuItem({
    required this.id,
    required this.title,
    required this.iconPath,
    this.isLocal = true,
  });
}

class HomeIconsController extends BaseController {
  final NotificationsController notifications;
  final BalanceController balance;

  HomeIconsController({required this.notifications, required this.balance});

  RxList<HomeIconsResponse> apiIcons = <HomeIconsResponse>[].obs;
  var hasLoadedIcons = false.obs;
  final RxBool incomplete = false.obs;

  final Map<String, String> _localIconAssets = {
    '1': 'assets/icons/ic_home_payment.png',
    '2': 'assets/icons/ic_home_qrcode.png',
    '10': 'assets/icons/ic_home_payment_invoice.png',
    '11': 'assets/icons/ic_home_transfer.png',
    '12': 'assets/icons/ic_home_recharge.png',
    '14': 'assets/icons/ic_home_store.png',
    '19': 'assets/icons/ic_home_pix.png',
    '30': 'assets/icons/ic_home_faq.png',
    '31': 'assets/icons/ic_home_warning.png',
    '23': 'assets/icons/ic_contabil.png',
    '24': 'assets/icons/ic_services.png',
  };

  List<HomeMenuItem> get combinedMenuList {
    List<HomeMenuItem> list = [];
    for (var icon in apiIcons) {
      list.add(HomeMenuItem(
        id: icon.id,
        title: icon.title,
        iconPath: _localIconAssets[icon.id] ?? '',
        isLocal: _localIconAssets.containsKey(icon.id),
      ));
    }

    list.add(HomeMenuItem(
      id: '23',
      title: 'contability_title'.tr,
      iconPath: _localIconAssets['23']!,
    ));
    list.add(HomeMenuItem(
      id: '24',
      title: 'services_title'.tr,
      iconPath: _localIconAssets['24']!,
    ));

    return list;
  }

  @override
  void onInit() {
    super.onInit();
    registerIncomplete();
    fetchIcons();
  }

  void registerIncomplete() {
    if (userRx.user.value?.payload.aliasAccount?.accountId == null) {
      incomplete.value = true;
    }
  }

  Future<void> fetchIcons() async {
    if (hasLoadedIcons.value) return;

    await executeSafe(() async {
      final fetchedIcons = await FetchIconsRepository().fetchIcons();
      if (fetchedIcons.isNotEmpty) {
        apiIcons.assignAll(fetchedIcons);
        hasLoadedIcons.value = true;
      }
    }, message: 'Erro ao carregar os ícones');
  }

  void onMenuOptionTap(String id, String title) {
    const restrictedIds = ['1', '2', '10', '11', '19'];

    if (restrictedIds.contains(id) && incomplete.value) {
      CustomDialogs.showInformationDialog(
          content:
              'Para utilizar essa funcionalidade é preciso completar seu cadastro',
          onCancel: () => Get.back());
      return;
    }

    switch (id) {
      case '1':
        Get.toNamed(AppRoutes.paymentLink);
        AppLogger.I().info('Going to Payment Link');
        break;
      case '2':
        Get.toNamed(AppRoutes.pixQrCodeReader);
        AppLogger.I().info('Going to QR Code Payment');
        break;
      case '10':
        Get.toNamed(AppRoutes.barcode);
        AppLogger.I().info('Going to Barcode Payment');
        break;
      case '11':
        Get.to(() => const TransferContactPage(),
            transition: Transition.rightToLeft);
        AppLogger.I().info('Going to Transfer Page');
        break;
      case '12':
        CustomDialogs.showInformationDialog(
            content: 'unavailable'.tr, onCancel: () => Get.back());
        break;
      case '14':
        Get.toNamed(AppRoutes.store);
        AppLogger.I().info('Going to Store Page');
        break;
      case '19':
        Get.toNamed(AppRoutes.pixHome);
        AppLogger.I().info('Going to Pix Home');
        break;
      case '30':
        _openWebView('https://miban4.com', title);
        AppLogger.I().info('Going to Message');
        break;
      case '31':
        _openWebView('https://miban4.com/#faq', title);
        AppLogger.I().info('Going to Warnings');
        break;
      case '23':
        // TODO: Contabilidade
        AppLogger.I().info('Going to Contabilidade');
        break;
      case '24':
        Get.toNamed(AppRoutes.services);
        AppLogger.I().info('Going to Services');
        break;
      default:
        AppLogger.I().info('Menu option $id not implemented');
    }
  }

  void _openWebView(String url, String title) {
    Get.to(
      () => WebviewPage(url: url, pageTitle: title),
      transition: Transition.rightToLeft,
    );
  }

  void openNotifications() {
    Get.toNamed(AppRoutes.notifications);
  }
}
