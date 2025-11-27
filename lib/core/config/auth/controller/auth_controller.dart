import 'package:app_flutter_miban4/core/config/auth/controller/auth_redirect_controller.dart';
import 'package:app_flutter_miban4/core/config/auth/controller/user_rx.dart';
import 'package:app_flutter_miban4/core/config/auth/model/auth_login_request.dart';
import 'package:app_flutter_miban4/core/config/auth/model/user.dart';
import 'package:app_flutter_miban4/core/config/auth/repositories/auth_repository.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/log/scope_config.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final UserRx user;
  AuthController({required this.user});

  var isLoading = false.obs;
  final box = GetStorage();
  final formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  final RxBool obscureText = true.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  Future<User?> authLogin() async {
    if (!formKey.currentState!.validate()) {
      return null;
    }

    try {
      isLoading(true);
      final doc = box.read('document');

      if (doc == null || doc.isEmpty) {
        AppLogger.I().error(
            'Auth Login', Exception('Document not found'), StackTrace.current);
        ShowToaster.toasterInfo(
            message: 'Documento não encontrado. Reinicie o app.');
        return null;
      }

      final auth = await AuthRepository().authLogin(
          loginRequest:
              AuthLoginRequest(document: doc, password: password.text));

      user.user.value = auth;

      await ScopeConfig.setup(auth);

      AppLogger.I().debug('Sentry Scope Initialized');

      if (auth.token.isNotEmpty) {
        AppLogger.I().info('Auth Login Success');
        box.write('token', auth.token);
        AppLogger.I().debug('Token ${auth.token} saved at Storage');

        AuthRedirect.login();
      }

      return auth;
    } catch (e, s) {
      if (e is ApiException) {
        AppLogger.I().error('Auth Login', e, s);
        if (e.statusCode == 401) {
          ShowToaster.toasterInfo(
            message: 'Senha incorreta. Tente novamente.',
            isError: true,
          );
        } else if (e.statusCode == 500) {
          CustomDialogs.showInformationDialog(
              content: 'Verifique sua conexão e tente novamente mais tarde.',
              onCancel: () => Get.offAllNamed(AppRoutes.splash));
        } else {
          ShowToaster.toasterInfo(
            message: e.message,
            isError: true,
          );
        }
      }
    } finally {
      isLoading(false);
    }
    return null;
  }
}
