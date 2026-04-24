import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/controller/tracking_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_controller.dart';
import 'package:app_flutter_miban4/features/completeProfile/repository/complete_profile_verify_steps_repository.dart';
import 'package:app_flutter_miban4/features/home/controller/home_controller.dart';
import 'package:app_flutter_miban4/features/home/model/home_icons_response.dart';
import 'package:app_flutter_miban4/features/home/repository/fetch_icons_repository.dart';
import 'package:app_flutter_miban4/features/notifications/controller/notifications_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeMenuItem {
  final String id;
  final String title;
  final String? iconPath;
  final IconData? iconData;
  final bool isLocal;
  final Color? color;

  HomeMenuItem({
    required this.id,
    required this.title,
    this.iconPath,
    this.iconData,
    this.isLocal = true,
    this.color,
  });
}

class HomeIconsController extends BaseController {
  final NotificationsController notifications;
  final BalanceController balance;

  HomeIconsController({required this.notifications, required this.balance});

  final homeViewController = Get.find<HomeViewController>();

  RxList<HomeIconsResponse> apiIcons = <HomeIconsResponse>[].obs;
  var hasLoadedIcons = false.obs;

  final RxBool incomplete = false.obs;
  final RxBool isAccountProcessing = false.obs;

  var isLoadingIa = false.obs;

  List<HomeMenuItem> get combinedMenuList {
    return [
      HomeMenuItem(
          id: 'favorites',
          title: 'Preferências',
          iconData: Icons.star_border_rounded),
      HomeMenuItem(
          id: 'myBiz', title: 'Meu Negócio', iconData: Icons.pie_chart_outline),
      HomeMenuItem(
          id: 'accounting',
          title: 'Gestão Contábil',
          iconPath: 'assets/icons/ic_contabil.png'),
      // HomeMenuItem(
      //     id: 'cashback',
      //     title: 'Membresia',
      //     iconData: Icons.account_balance_wallet_outlined),
      HomeMenuItem(
          id: 'marketplace',
          title: 'Marketplace',
          iconData: Icons.storefront_outlined),
      HomeMenuItem(id: 'score', title: 'Crédito', iconData: Icons.bar_chart),
      HomeMenuItem(
          id: 'news', title: 'Notícias', iconData: Icons.newspaper_outlined),
      HomeMenuItem(
          id: 'mei', title: 'Documentos', iconData: Icons.business_outlined),
      // HomeMenuItem(
      //     id: 'ai', title: 'IA', iconData: Icons.auto_awesome_outlined),
      // --- ESTOQUE OCULTO TEMPORARIAMENTE ---
      // HomeMenuItem(
      //     id: 'stock', title: 'Estoque', iconData: Icons.receipt_long_outlined),
      HomeMenuItem(
          id: 'clients',
          title: 'Meus Clientes',
          iconData: Icons.people_outline),
      HomeMenuItem(
          id: 'contact',
          title: 'Fale Conosco',
          iconData: Icons.headset_mic_outlined),
      HomeMenuItem(
          id: 'health',
          title: 'Telemedicina',
          iconData: Icons.health_and_safety_outlined),
      HomeMenuItem(
        id: 'pix',
        title: 'Pix',
        iconPath: 'assets/icons/ic_home_pix.png',
      ),
      HomeMenuItem(
          id: 'partners',
          title: 'Nossos Parceiros',
          iconData: Icons.handshake_outlined),
    ];
  }

  @override
  void onInit() {
    super.onInit();
    checkProfileStatus();
    fetchIcons();
  }

  Future<void> openFaciapLink() async {
    const String url = 'https://site.faciap.org.br/nossos-parceiros/';
    const String title = 'Sobre a FACIAP';

    if (kIsWeb) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } else {
      Get.toNamed(AppRoutes.webView, arguments: {
        'url': url,
        'title': title,
      });
    }
  }

  Future<void> checkProfileStatus() async {
    final document = userRx.user.value?.payload.document;
    if (document == null || document.isEmpty) return;

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

      final hasAliasAccount = userRx.user.value?.payload.aliasAccount != null;

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
    }, message: 'Erro ao carregar os ícones', showErrorToast: false);
  }

  // --- DICIONÁRIO DE TRACKING DE CLIQUES ---
  // Passe esta lista de IDs para o seu backend saber quem é quem!
  int _getTrackingId(String stringId) {
    switch (stringId) {
      case 'cashback':
        return 1; // Membresia
      case 'marketplace':
        return 2; // Marketplace
      case 'score':
        return 3; // Crédito
      case 'news':
        return 4; // Notícias
      case 'ai':
        return 5; // IA
      case 'accounting':
        return 6; // Contabilidade
      case 'partners':
        return 7; // Nossos Parceiros
      case 'clients':
        return 8; // Meus Clientes
      case 'contact':
        return 9; // Fale Conosco
      case 'myBiz':
        return 10;
      case 'health':
        return 11;
      case 'pix':
        return 15;
      // Itens não solicitados para trackear (retornam 0)
      case 'favorites':
        return 0;
      case 'mei':
        return 0;
      default:
        return 0;
    }
  }

  void onMenuOptionTap(String id, String title) async {
    // --- RESTRIÇÕES DESATIVADAS TEMPORARIAMENTE ---
    /*
    if (incomplete.value) { ... }
    if (isAccountProcessing.value) { ... }
    */

    // --- 1. REGISTRA O CLIQUE LOCALMENTE ---
    int trackingId = _getTrackingId(id);
    if (trackingId != 0) {
      TrackerController.to.trackClick(trackingId);
      AppLogger.I().info('Tracked click for $title (ID: $trackingId)');
    }

    // --- 2. NAVEGAÇÃO NORMAL DO APP ---
    switch (id) {
      case 'favorites':
        Get.toNamed(AppRoutes.favButtons);
        AppLogger.I().info('Going to Favorites Page');
        break;
      case 'marketplace':
        homeViewController.onItemTapped(2);
        AppLogger.I().info('Going to Marketplace Page');
        break;
      case 'myBiz':
        Get.toNamed(AppRoutes.myBiz);
        AppLogger.I().info('Going to My Biz PAge');
        break;
      case 'accounting':
        Get.toNamed(AppRoutes.accountingHome);
        AppLogger.I().info('Going to Accounting Page');
        break;
      case 'ai':
        openAiSearch();
        break;
      case 'statement_btn':
        Get.toNamed(AppRoutes.statement);
        AppLogger.I().info('Going to Statement Page');
        break;
      case 'news':
        Get.toNamed(AppRoutes.newsletter);
        AppLogger.I().info('Going to Newsletter Page');
        break;
      case 'cashback':
        Get.toNamed(AppRoutes.cashback);
        AppLogger.I().info('Going to Cashback Page');
        break;
      case 'score':
        Get.toNamed(AppRoutes.score);
        AppLogger.I().info('Going to Score Page');
        break;
      case 'mei':
        Get.toNamed(AppRoutes.mei);
        AppLogger.I().info('Going to Mei Page');
        break;
      case 'partners':
        Get.toNamed(AppRoutes.partners);
        AppLogger.I().info('Going to Partners Page');
        break;
      case 'contact':
        Get.toNamed(AppRoutes.contacts);
        AppLogger.I().info('Going to Contacts Page');
        break;
      case 'clients':
        Get.toNamed(AppRoutes.clients);
        AppLogger.I().info('Going to Clients Page');
        break;
      case 'health':
        Get.toNamed(AppRoutes.healthHome);
        AppLogger.I().info('Going to Health Page');
        break;
      case 'pix':
        Get.toNamed(AppRoutes.pixHome);
        AppLogger.I().info('Going to Pix Home');
        break;
      // case 'stock':
      //   Get.toNamed(AppRoutes.stock);
      //   AppLogger.I().info('Going to Stock Page');
      //   break;
      default:
        AppLogger.I().info('Menu option $id not implemented');
        ShowToaster.toasterInfo(message: 'Em breve $title funcionalidade.');
    }
  }

  void openNotifications() {
    Get.toNamed(AppRoutes.notifications);
  }

  void openAiSearch() {
    Get.toNamed(AppRoutes.aiPage);
  }
}
