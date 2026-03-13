import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class ContactController extends BaseController {
  // Preencha com os dados reais do M4 / FACIAP
  final String phoneNumber = '+5511999999999';
  final String emailAddress = 'contato@m4.com.br';

  void openWhatsApp() {
    Get.rawSnackbar(
      message: 'Atendimento via WhatsApp estará disponível em breve.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      backgroundColor: Colors.black87,
    );
  }

  Future<void> callPhone() async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Get.rawSnackbar(
        message: 'Não foi possível abrir o discador do seu aparelho.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> sendEmail() async {
    final Uri url = Uri.parse('mailto:$emailAddress');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Get.rawSnackbar(
        message: 'Não foi possível abrir o seu cliente de e-mail.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
