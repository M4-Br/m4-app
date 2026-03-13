import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/partners/model/partners_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PartnersController extends BaseController {
  final List<MainPartnerModel> mainPartners = [
    MainPartnerModel(
      name: 'Sicredi',
      description:
          'O Sicredi apoia ativamente os eventos e ações das associações comerciais. Além disso, oferece descontos exclusivos para os associados, incluindo condições especiais de crédito nas cooperativas.',
      logoAsset: 'assets/icons/sicredi_icon.png',
    ),
    MainPartnerModel(
      name: 'Sebrae',
      description:
          'O Sebrae é um grande apoiador das ações e eventos das associações comerciais, contribuindo para o desenvolvimento das micro e pequenas empresas.',
      logoAsset: 'assets/icons/sebrae_icon.png',
    ),
    MainPartnerModel(
      name: 'Cresol',
      description:
          'A Cresol é parceira das associações comerciais, apoiando seus eventos e iniciativas. Os associados também desfrutam de descontos exclusivos e condições diferenciadas de crédito nas cooperativas.',
      logoAsset: 'assets/icons/cresol_icon.png',
      url: 'https://exemplo.com/cresol',
    ),
    MainPartnerModel(
      name: 'Sicoob',
      description:
          'O Sicoob apoia as iniciativas e eventos das associações comerciais. Além disso, disponibilizamos condições vantajosas de crédito nas cooperativas.',
      logoAsset: 'assets/icons/sicoob_icon.png',
    ),
  ];

  // Lista de Outros Parceiros (Grid)
  final List<OtherPartnerModel> otherPartners = [
    OtherPartnerModel(name: 'Varitus', url: 'https://varitus.com.br/faciap/'),
    OtherPartnerModel(name: 'Becomex', url: 'https://becomex.com.br/'),
    OtherPartnerModel(name: 'ANBC', url: 'https://anbc.org.br/'),
    OtherPartnerModel(name: 'GPTW', url: 'https://gptw.com.br/'),
    OtherPartnerModel(
        name: 'Caixa Econômica',
        url: 'https://materiais.faciap.org.br/faciap-e-caixa-economica-lp'),
  ];

  Future<void> openUrl(String? url, String title) async {
    if (url == null || url.isEmpty || url.startsWith('https://exemplo.com')) {
      Get.rawSnackbar(
        message: 'O link para "$title" ainda não foi configurado.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return;
    }

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

  // Ação do banner final
  void goToAssociation() {
    ShowToaster.toasterInfo(message: 'Em breve');
  }
}
