import 'package:app_flutter_miban4/data/api/login/authLogin.dart';
import 'package:app_flutter_miban4/data/api/pix/pixCreateKey.dart';
import 'package:app_flutter_miban4/data/model/pix/pixCreateKey.dart';
import 'package:app_flutter_miban4/data/model/userData/user.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixMyKeys.dart';
import 'package:get/get.dart';

class CreateKeyController extends GetxController {
  var isLoading = false.obs;

  Future<void> createPixKey(String document, String password, String key, String keyType) async {
    isLoading(true);

    try {
      UserData userData = await verifyLogin(document, password);

      if (userData.success == true) {
        await SharedPreferencesFunctions.saveString(
            key: 'token', value: userData.token.toString());
        try {
          PixCreateKey pixKey = await createKey(key, keyType);

          if (pixKey.success == true) {
            isLoading(false);
            Get.to(() => const PixMyKeys(), transition: Transition.rightToLeft);
          } else {
            throw Exception("Erro ao criar chave: ${pixKey.toString()}");
          }
        } catch (error) {
          isLoading(false);
          throw Exception(error);
        }
      }
    } catch (error) {
      isLoading(false);
      throw Exception(error);
    } finally {
      isLoading(false);
    }
  }
}
