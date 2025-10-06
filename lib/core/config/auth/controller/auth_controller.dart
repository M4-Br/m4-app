import 'package:app_flutter_miban4/core/config/auth/controller/auth_redirect_controller.dart';
import 'package:app_flutter_miban4/core/config/auth/controller/user_controller.dart';
import 'package:app_flutter_miban4/core/config/auth/model/auth_login_request.dart';
import 'package:app_flutter_miban4/core/config/auth/model/user.dart';
import 'package:app_flutter_miban4/core/config/auth/repositories/auth_repository.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final UserController user;
  AuthController({required this.user});

  var isLoading = false.obs;
  final box = GetStorage();
  final formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  var obscureText = true.obs;

  Future<User?> authLogin() async {
    try {
      isLoading(true);
      final doc = box.read('document');

      if (doc == null || doc.isEmpty) {
        AppLogger.I().error(
            'Auth Login', Exception('Document not find'), StackTrace.current);
        throw Exception(
            'Documento não encontrado. Faça a verificação antes do login.');
      }
      final auth = await AuthRepository().authLogin(
          loginRequest:
              AuthLoginRequest(document: doc, password: password.text));

      user.user.value = auth;

      if (auth.token.isNotEmpty) {
        AppLogger.I().info('Auth Login Success');
        box.write('token', auth.token);
        AppLogger.I().debug('Token ${auth.token} saved at Storage');

        AuthRedirect.login();
      }

      return auth;
    } catch (e, s) {
      AppLogger.I().error('Auth Login', e, s);
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
