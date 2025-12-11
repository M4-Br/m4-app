import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardWidget extends GetView<BalanceController> {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = controller.userRx.user.value;
    if (currentUser == null) {
      return SizedBox(
        height: 200,
        child: Center(
          child: AppText.bodyMedium(context, 'Dados do Usuário indisponíveis'),
        ),
      );
    }

    final Color cardColor = currentUser.payload.cardColor;
    final Color fontColor = currentUser.payload.cardFontColor;
    final String assetPath;

    switch (currentUser.payload.companyId) {
      case 1:
        assetPath = 'assets/images/m4_ic_logo.png';
        break;
      case 2:
        assetPath = 'assets/images/acme_logo.png';
        break;
      default:
        assetPath = 'assets/images/m4_ic_logo.png';
    }

    return Container(
      height: 220,
      alignment: Alignment.topLeft,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_darkenColor(cardColor), cardColor],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Image.asset(assetPath, width: 100),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: AppText.titleMedium(
                context,
                'balance_available'.tr,
                color: fontColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  Obx(() {
                    final balance = controller.balanceRx.balance.value;

                    if (controller.isLoading.value) {
                      return const SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }

                    if (balance == null) {
                      return AppText.bodyLarge(context, 'Indisponível',
                          color: fontColor);
                    }

                    return AppText.bodyLarge(
                      context,
                      controller.isVisible.value
                          ? balance.balanceCents.toBRL()
                          : '******',
                      color: fontColor,
                    );
                  }),
                  const Spacer(),
                  IconButton(
                    onPressed: () => controller.toggleVisibility(),
                    icon: Obx(
                      () => controller.isVisible.value
                          ? Icon(
                              Icons.visibility_off_outlined,
                              color: fontColor,
                            )
                          : Icon(
                              Icons.visibility_outlined,
                              color: fontColor,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: AppText.titleMedium(
                context,
                'balance_transational'.tr,
                color: fontColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Obx(() {
                final balance = controller.balanceRx.balance.value;

                if (controller.isLoading.value) {
                  return const SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }

                if (balance == null) {
                  return AppText.bodyLarge(context, 'Indisponível',
                      color: fontColor);
                }

                return AppText.bodyLarge(
                  context,
                  controller.isVisible.value
                      ? balance.transactionalValue.toBRL()
                      : '******',
                  color: fontColor,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Color _darkenColor(Color color, [double amount = 0.2]) {
    assert(amount >= 0 && amount <= 1);
    return Color.lerp(color, Colors.black, amount)!;
  }
}
