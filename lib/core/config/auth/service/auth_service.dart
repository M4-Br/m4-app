import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final _box = GetStorage();
  final RxnString token = RxnString();

  bool get isLogged => token.value != null && token.value!.isNotEmpty;

  Future<AuthService> init() async {
    final storedToken = _box.read('token');

    if (storedToken != null && storedToken.isNotEmpty) {
      token.value = storedToken;
    }
    return this;
  }

  void loginSuccess(String newToken) {
    token.value = newToken;
  }

  void logout() async {
    token.value = null;
    await _box.remove('token');
    Get.offAllNamed(AppRoutes.splash);
  }
}
