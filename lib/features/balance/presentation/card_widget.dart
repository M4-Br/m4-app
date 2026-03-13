import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
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

    final Color fontColor = currentUser.payload.cardFontColor;
    final String assetPath;

    switch (currentUser.payload.companyId) {
      case 1:
      case 2:
        assetPath = 'assets/images/ic_faciap.png';
        break;
      default:
        assetPath = 'assets/images/ic_faciap.png';
    }

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.offersHome),
      child: Center(
        // Garante que na Web o card fique centralizado se houver muito espaço
        child: Container(
          height: 200, // Altura padrão de um cartão
          width: double.infinity, // Tenta preencher a tela...
          constraints: const BoxConstraints(
              maxWidth:
                  380), // ...mas trava no máximo em 380px (tamanho de celular grande)
          padding:
              const EdgeInsets.all(24), // Padding uniforme em volta de tudo
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.15), // Uma sombrinha leve para dar destaque
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF2E7D32),
                Color.fromARGB(255, 230, 213, 63),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo com altura fixa (não usa mais MediaQuery)
              Image.asset(
                assetPath,
                height: 36,
                fit: BoxFit.contain,
              ),

              const Spacer(),

              AppText.titleMedium(
                context,
                'balance_available'.tr,
                color: fontColor,
              ),

              Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      final balance = controller.balanceRx.balance.value;

                      if (controller.isLoading.value) {
                        return const Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      }

                      if (balance == null) {
                        return AppText.bodyLarge(context, 'Indisponível',
                            color: fontColor);
                      }

                      return AppText.headlineMedium(
                        context,
                        controller.isVisible.value
                            ? balance.balanceCents.toBRL()
                            : 'R\$ *****',
                        color: fontColor,
                      );
                    }),
                  ),

                  // Botão do olhinho
                  IconButton(
                    onPressed: () => controller.toggleVisibility(),
                    padding: EdgeInsets
                        .zero, // Remove o padding interno do botão para alinhar melhor
                    constraints: const BoxConstraints(),
                    icon: Obx(
                      () => Icon(
                        controller.isVisible.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: fontColor,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
