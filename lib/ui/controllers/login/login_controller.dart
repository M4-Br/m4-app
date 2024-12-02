import 'package:app_flutter_miban4/data/api/home/params.dart';
import 'package:app_flutter_miban4/data/api/login/authLogin.dart';
import 'package:app_flutter_miban4/data/api/plans/user_plan.dart';
import 'package:app_flutter_miban4/data/model/userData/user.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/controllers/home/home_controller.dart';
import 'package:app_flutter_miban4/ui/controllers/login/user_controller.dart';
import 'package:app_flutter_miban4/ui/controllers/params/params_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  var obscureText = true.obs;
  String document = '';
  final TextEditingController passwordController = TextEditingController();


  Future<void> login(String document) async {
    final UserController userController = Get.find();
    final ParamsController paramsController = Get.put(ParamsController());
    final HomeController homeController = Get.put(HomeController());

    isLoading(true);

    try {
      final UserData response = await verifyLogin(document, passwordController.text);


      if (response.success == true) {
        await SharedPreferencesFunctions.saveString(
            key: 'token', value: response.token.toString());
        await SharedPreferencesFunctions.saveString(
            key: 'username', value: response.payload.fullName);
        await SharedPreferencesFunctions.saveString(
            key: 'user', value: response.payload.username);
        await SharedPreferencesFunctions.saveString(
            key: 'pass', value: passwordController.text);

        await fetchAndStoreParams();
        await homeController.getIcons();
        await getUserPlans();

        userController.userData.value = response;

        Get.off(() => const HomeViewPage(), transition: Transition.rightToLeft);
      } else {
        throw Exception("Resposta inválida da API");
      }
    } catch (error) {
      isLoading(false);
      throw Exception(error.toString());
    }
  }

  codeLang() async {
    await SharedPreferencesFunctions.saveString(
        key: 'codeLang', value: 'codeLang'.tr);
  }
}
