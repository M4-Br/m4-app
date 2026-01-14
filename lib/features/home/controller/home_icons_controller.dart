import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_controller.dart';
// Importe o Repository e o Model
import 'package:app_flutter_miban4/features/completeProfile/repository/complete_profile_verify_steps_repository.dart';
import 'package:app_flutter_miban4/features/home/model/home_icons_response.dart';
import 'package:app_flutter_miban4/features/home/repository/fetch_icons_repository.dart';
import 'package:app_flutter_miban4/features/notifications/controller/notifications_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/features/profile/controller/profile_controller.dart';
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
  final RxBool isAccountProcessing = false.obs;

  var isLoading = false.obs;

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
    checkProfileStatus();
    fetchIcons();
  }

  Future<void> checkProfileStatus() async {
    final document = userRx.user.value?.payload.document;
    if (document == null) return;

    try {
      final result = await CompleteProfileVerifyStepsRepository()
          .fetchProfileSteps(document);

      final hasPendingSteps = result.steps.any((step) {
        return step.stepId >= 3 && step.stepId <= 8 && !step.done;
      });

      if (hasPendingSteps) {
        incomplete.value = true;
        isAccountProcessing.value = false;
        return;
      }

      incomplete.value = false;

      final hasAliasAccount =
          userRx.user.value?.payload.aliasAccount?.accountId != null;

      if (!hasAliasAccount) {
        isAccountProcessing.value = true;
      } else {
        isAccountProcessing.value = false;
      }
    } catch (e) {
      AppLogger.I().error('Home Check Profile', e, StackTrace.current);
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

  void onMenuOptionTap(String id, String title) async {
    const restrictedIds = ['1', '2', '10', '11', '19'];

    if (restrictedIds.contains(id)) {
      if (incomplete.value) {
        CustomDialogs.showConfirmationDialog(
          loading: isLoading,
          title: 'Cadastro Incompleto',
          content:
              'Para utilizar essa funcionalidade é preciso finalizar os passos do seu cadastro.',
          confirmText: 'Completar',
          onConfirm: () async {
            isLoading.value = true;
            await Get.find<ProfileController>().redirectToCompleteProfile();
            isLoading.value = false;
            if (Get.currentRoute == AppRoutes.homeView) {
              Get.back();
            }
          },
        );
        return;
      }

      if (isAccountProcessing.value) {
        CustomDialogs.showInformationDialog(
            title: 'Conta em Análise',
            content:
                'Seu cadastro foi enviado e sua conta bancária está sendo criada. Aguarde alguns instantes.',
            onCancel: () => Get.back());
        return;
      }
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
        Get.toNamed(AppRoutes.transfer);
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
    Get.toNamed(AppRoutes.webView, arguments: {'url': url, 'title': title});
  }

  void openNotifications() {
    Get.toNamed(AppRoutes.notifications);
  }
}
