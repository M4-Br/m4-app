import 'package:app_flutter_miban4/data/api/home/params.dart';
import 'package:app_flutter_miban4/data/api/login/authLogin.dart';
import 'package:app_flutter_miban4/data/model/params/params.dart';
import 'package:app_flutter_miban4/data/model/userData/bank.dart';
import 'package:app_flutter_miban4/data/model/userData/user.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/controllers/home/home_controller.dart';
import 'package:app_flutter_miban4/ui/controllers/login/user_controller.dart';
import 'package:app_flutter_miban4/ui/controllers/params/params_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String document, String password) async {
    final UserController userController = Get.find();
    final ParamsController paramsController = Get.put(ParamsController());
    final HomeController homeController = Get.put(HomeController());

    isLoading(true);

    try {
      final UserData response = await verifyLogin(document, password);


      if (response.success == true) {
        await SharedPreferencesFunctions.saveString(
            key: 'token', value: response.token.toString());
        await SharedPreferencesFunctions.saveString(
            key: 'username', value: response.payload.fullName);
        await SharedPreferencesFunctions.saveString(
            key: 'user', value: response.payload.username);
        await SharedPreferencesFunctions.saveString(
            key: 'pass', value: password);

        await fetchAndStoreParams();
        await homeController.getIcons();

        userController.userData.value = response;

        Get.off(() => HomeViewPage(), transition: Transition.rightToLeft);
      } else {
        throw Exception("Resposta inválida da API");
      }
    } catch (error) {
      isLoading(false);
      throw Exception(error.toString());
    }
  }
}
