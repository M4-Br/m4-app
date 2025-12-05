import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/pix/home/controller/pix_home_controller.dart';
import 'package:app_flutter_miban4/features/pix/home/presentation/widgets/pix_home_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixHomePage extends GetView<PixHomeController> {
  const PixHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'PIX',
      ),
      body: CustomPageBody(
        padding: EdgeInsets.zero,
        children: [
          _buildCard(context),
          _buildMenuIcons(context),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Container(
      width: double.infinity,
      color: primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.titleLarge(
                  context,
                  'balance_available'.tr,
                  color: Colors.white,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        final isVisible = controller.isVisible.value;
                        final balanceValue = controller.balance.balance.value;
                        return AppText.headlineMedium(
                          context,
                          isVisible
                              ? (balanceValue?.balanceCents.toBRL() ??
                                  'R\$ ...')
                              : '*****',
                          color: Colors.white,
                        );
                      }),
                    ),
                    IconButton(
                      onPressed: () => controller.toggleVisibility(),
                      icon: Obx(
                        () => Icon(
                          controller.isVisible.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                AppText.titleMedium(context, 'balance_transational'.tr,
                    color: Colors.white70),
                Obx(() {
                  final isVisible = controller.isVisible.value;
                  final balanceValue = controller.balance.balance.value;
                  return AppText.headlineSmall(
                    context,
                    isVisible
                        ? (balanceValue?.transactionalValue.toBRL() ??
                            'R\$ ...')
                        : '*****',
                    color: Colors.white,
                  );
                }),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => controller.goToStatement(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.kDefaultPadding,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.white24, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.bodyLarge(
                      context,
                      'pix_statement'.tr,
                      color: Colors.white,
                    ),
                    const Icon(Icons.chevron_right_rounded,
                        color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuIcons(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppDimens.kDefaultPadding),
      child: Column(
        children: [
          const SizedBox(height: 20),
          PixHomeItem(
            name: 'pix_manager_keys'.tr,
            description: 'pix_manage_data'.tr,
            icon: Icons.account_tree_outlined,
            onPressed: () => controller.goToPixKeyManager(),
          ),
          PixHomeItem(
            name: 'pix_myLimits'.tr,
            description: 'pix_setLimit'.tr,
            icon: Icons.attach_money_outlined,
            onPressed: () => controller.goToLimits(),
          ),
          PixHomeItem(
            name: 'pix_receive'.tr,
            description: 'pix_receiveValue'.tr,
            icon: Icons.pix_outlined,
            onPressed: () => controller.goToReceivePix(),
          ),
          PixHomeItem(
            name: 'pix_key'.tr,
            description: 'pix_payKey'.tr,
            icon: Icons.phonelink_sharp,
            onPressed: () => controller.goToPixWithKey(),
          ),
          PixHomeItem(
            name: 'pix_schedule_transfer'.tr,
            description: 'Gerencie seus pix agendados',
            icon: Icons.schedule_outlined,
            onPressed: () => controller.goToScheduledPix(),
          ),
          PixHomeItem(
            name: 'pix_qrCode'.tr,
            description: 'pix_payQrCode'.tr,
            icon: Icons.qr_code_2_outlined,
            onPressed: () => controller.goToPixQrCodeReader(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: PixHomeItem(
              name: 'pix_copyPaste'.tr,
              description: 'pix_payCopy'.tr,
              icon: Icons.copy_outlined,
              onPressed: () => controller.goToCopyPaste(),
            ),
          ),
        ],
      ),
    );
  }
}
