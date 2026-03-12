import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/AI/widget/ai_show_modal.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_controller.dart';
import 'package:app_flutter_miban4/features/completeProfile/repository/complete_profile_verify_steps_repository.dart';
import 'package:app_flutter_miban4/features/home/model/home_icons_response.dart';
import 'package:app_flutter_miban4/features/home/repository/fetch_icons_repository.dart';
import 'package:app_flutter_miban4/features/notifications/controller/notifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMenuItem {
  final String id;
  final String title;
  final String? iconPath;
  final IconData? iconData;
  final bool isLocal;

  HomeMenuItem({
    required this.id,
    required this.title,
    this.iconPath,
    this.iconData,
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

  var isLoadingIa = false.obs;

  List<HomeMenuItem> get combinedMenuList {
    return [
      HomeMenuItem(
          id: 'cashback',
          title: 'Cashback',
          iconData: Icons.account_balance_wallet_outlined),
      HomeMenuItem(
          id: 'marketplace',
          title: 'Marketplace',
          iconData: Icons.storefront_outlined),
      HomeMenuItem(
          id: 'score', title: 'Consulta de Crédito', iconData: Icons.bar_chart),
      HomeMenuItem(
          id: 'news', title: 'Notícias', iconData: Icons.newspaper_outlined),
      HomeMenuItem(
          id: 'mei', title: 'Serviços MEI', iconData: Icons.business_outlined),
      HomeMenuItem(
          id: 'ai',
          title: 'Assistente MEI',
          iconData: Icons.chat_bubble_outline),
      HomeMenuItem(
          id: 'stock', title: 'Estoque', iconData: Icons.receipt_long_outlined),
      HomeMenuItem(
          id: 'accounting',
          title: 'Contabilidade',
          iconData: Icons.pie_chart_outline),
      HomeMenuItem(
          id: 'partners',
          title: 'Nossos Parceiros',
          iconData: Icons.handshake_outlined),
      HomeMenuItem(
          id: 'clients',
          title: 'Meus Clientes',
          iconData: Icons.people_outline),
      HomeMenuItem(
          id: 'contact',
          title: 'Fale Conosco',
          iconData: Icons.headset_mic_outlined),
    ];
  }

  @override
  void onInit() {
    super.onInit();
    checkProfileStatus();
    fetchIcons();
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

  void onMenuOptionTap(String id, String title) async {
    // --- RESTRIÇÕES DESATIVADAS TEMPORARIAMENTE ---
    /*
    if (incomplete.value) { ... }
    if (isAccountProcessing.value) { ... }
    */

    switch (id) {
      case 'marketplace':
        Get.toNamed(AppRoutes.marketplace);
        AppLogger.I().info('Going to Marketplace Page');
        break;
      case 'accounting':
        Get.toNamed(AppRoutes.accountingHome); // Mapeado da sua rota antiga
        AppLogger.I().info('Going to Accounting');
        break;
      case 'ai':
        openAiSearch();
        break;
      case 'statement_btn': // Usado dentro do BottomSheet da Carteira
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
      // Adicione os outros redirecionamentos conforme for criando as rotas
      default:
        AppLogger.I().info('Menu option $id not implemented');
        ShowToaster.toasterInfo(message: 'Em breve $title funcionalidade.');
    }
  }

  void openNotifications() {
    Get.toNamed(AppRoutes.notifications);
  }

  void openAiSearch() {
    // --- RESTRIÇÕES DESATIVADAS TEMPORARIAMENTE ---
    /*
    if (incomplete.value) { ... }
    if (isAccountProcessing.value) { ... }
    */

    AiModal.openAiSearch();
  }
}
