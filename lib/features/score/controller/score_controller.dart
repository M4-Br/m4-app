import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:get/get.dart';

class ScoreController extends BaseController {
  void openSpcWebView() {
    const spcUrl =
        'https://login.spcbrasil.com.br/realms/associado/protocol/openid-connect/auth?response_type=code&client_id=spcjava&scope=openid+email+profile&redirect_uri=https%3A%2F%2Fsistema.spcbrasil.com.br%2Fspc%2Fopenid_connect_login&nonce=f3b3ae4b00f5&state=3c923399c920b';

    Get.toNamed(AppRoutes.webView, arguments: {
      'url': spcUrl,
      'title': 'Consulta SPC Brasil',
    });
  }
}
