import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ScoreController extends BaseController {
  Future<void> openSpcWebView() async {
    const spcUrl =
        'https://login.spcbrasil.com.br/realms/associado/protocol/openid-connect/auth?response_type=code&client_id=spcjava&scope=openid+email+profile&redirect_uri=https%3A%2F%2Fsistema.spcbrasil.com.br%2Fspc%2Fopenid_connect_login&nonce=f3b3ae4b00f5&state=3c923399c920b';

    CustomDialogs.showConfirmationDialog(
      title: 'Serviço Externo',
      content:
          'Você está acessando um serviço externo e a Yooconn não se responsabiliza pelos dados fornecidos.',
      confirmText: 'Acessar',
      cancelText: 'Cancelar',
      onConfirm: () async {
        Get.back();
        if (kIsWeb) {
          final uri = Uri.parse(spcUrl);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        } else {
          Get.toNamed(AppRoutes.webView, arguments: {
            'url': spcUrl,
            'title': 'Consulta SPC Brasil',
          });
        }
      },
    );
  }
}
