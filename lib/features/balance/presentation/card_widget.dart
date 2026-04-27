import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart'; // Mantido caso o toBRL venha daqui
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_controller.dart';
import 'package:flutter/foundation.dart'; // Necessário para o kIsWeb
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart'; // Necessário para abrir links na Web

class CardWidget extends GetView<BalanceController> {
  const CardWidget({super.key});

  // --- FUNÇÃO PARA ABRIR A URL HÍBRIDA ---
  Future<void> _openNews() async {
    const String url = 'https://site.faciap.org.br/noticias/';
    const String title = 'Notícias FACIAP';

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

    switch (currentUser.payload.companyId) {
      case 1:
      case 2:
        break;
      default:
    }

    return GestureDetector(
      // --- ONTAP ATUALIZADO AQUI ---
      onTap: _openNews,
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
                color: Colors.black.withValues(
                    alpha: 0.15), // Uma sombrinha leve para dar destaque
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
              // Image.asset(
              //   assetPath,
              //   height: 36,
              //   fit: BoxFit.contain,
              // ),

              // const Spacer(),

              AppText.titleMedium(
                context,
                'balance_available'.tr,
                color: fontColor,
              ),
              Spacer(),

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
