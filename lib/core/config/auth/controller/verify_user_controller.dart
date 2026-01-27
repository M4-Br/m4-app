import 'package:app_flutter_miban4/core/config/app/app_lifecycle_controller.dart';
import 'package:app_flutter_miban4/core/config/auth/controller/auth_redirect_controller.dart';
import 'package:app_flutter_miban4/core/config/auth/controller/user_rx.dart';
import 'package:app_flutter_miban4/core/config/auth/model/auth_login_request.dart';
import 'package:app_flutter_miban4/core/config/auth/model/verify_user_response.dart';
import 'package:app_flutter_miban4/core/config/auth/repositories/auth_repository.dart';
import 'package:app_flutter_miban4/core/config/auth/service/auth_service.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/log/scope_config.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/mask.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';

class VerifyAccountController extends GetxController {
  VerifyAccountController();

  final RxString documentText = ''.obs;

  var isLoading = false.obs;
  TextEditingController document = TextEditingController();
  final box = GetStorage();
  final formKey = GlobalKey<FormState>();

  // --- BIOMETRIA ---
  final _secureStorage = const FlutterSecureStorage();
  final _localAuth = LocalAuthentication();
  final canCheckBiometrics = false.obs;
  final UserRx userRx = Get.find<UserRx>();
  // -----------------

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      documentText.value = arguments['document'] ?? '';
    }
    lastLogin();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    try {
      final bool canAuthenticateWithBiometrics =
          await _localAuth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();

      IOSOptions iOptions =
          const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

      final storedPass =
          await _secureStorage.read(key: 'user_password', iOptions: iOptions);
      final storedDoc =
          await _secureStorage.read(key: 'user_document', iOptions: iOptions);

      final bool isAvailable =
          canAuthenticate && (storedPass != null && storedDoc != null);

      canCheckBiometrics.value = isAvailable;

      // Motivo: No iOS, chamar isso automaticamente no onInit causa conflito de UI
      // e pode gerar crash se o SecureStorage não estiver pronto.
      /* if (isAvailable) {
        await Future.delayed(const Duration(milliseconds: 500));
        loginWithBiometrics(); 
      }
      */
    } catch (e, s) {
      AppLogger.I().error('Erro ao verificar biometria', e, s);
    }
  }

  Future<void> loginWithBiometrics() async {
    try {
      if (Get.isRegistered<AppLifecycleController>()) {
        Get.find<AppLifecycleController>().setAuthenticating(true);
      }

      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Autenticar para entrar',
        options:
            const AuthenticationOptions(stickyAuth: true, biometricOnly: true),
      );

      if (didAuthenticate) {
        isLoading(true);
        final storedDoc = await _secureStorage.read(key: 'user_document');
        final storedPass = await _secureStorage.read(key: 'user_password');

        if (storedDoc != null && storedPass != null) {
          await _performDirectLogin(storedDoc, storedPass);
        } else {
          ShowToaster.toasterInfo(message: 'Credenciais expiradas.');
        }
      }
    } on PlatformException catch (e) {
      AppLogger.I().error('Biometria Platform Error', e, StackTrace.current);
    } catch (e) {
      AppLogger.I().error('Biometria Error', e, StackTrace.current);
    } finally {
      isLoading(false);
      await Future.delayed(const Duration(milliseconds: 500));

      if (Get.isRegistered<AppLifecycleController>()) {
        Get.find<AppLifecycleController>().setAuthenticating(false);
      }
    }
  }

  Future<void> _performDirectLogin(String doc, String pass) async {
    try {
      final auth = await AuthRepository().authLogin(
          loginRequest: AuthLoginRequest(document: doc, password: pass));

      userRx.user.value = auth;
      await ScopeConfig.setup(auth);

      if (auth.token.isNotEmpty) {
        AppLogger.I().info('Biometric Login Success');
        box.write('token', auth.token);
        box.write('document', auth.payload.document);

        AuthService.to.loginSuccess(auth.token);

        AuthRedirect.login();
      }
    } catch (e, s) {
      if (e is ApiException) {
        if (e.statusCode == 401) {
          ShowToaster.toasterInfo(
              message: 'Senha salva inválida. Digite novamente.',
              isError: true);
        } else {
          ShowToaster.toasterInfo(message: e.message, isError: true);
        }
      } else {
        AppLogger.I().error('Erro Login Biometria', e, s);
      }
    }
  }

  Future<VerifyUserResponse?> authVerify() async {
    if (!formKey.currentState!.validate()) {
      return null;
    }

    final cleanDoc = document.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (kDebugMode) {
      print('--- DEBUG LOGIN ---');
      print('Original: ${document.text}');
      print('Limpo: $cleanDoc');
      print('Tamanho: ${cleanDoc.length}');
      print('É CPF Válido (GetUtils)? ${GetUtils.isCpf(cleanDoc)}');
      print('-------------------');
    }

    if (cleanDoc.length <= 11) {
      if (!GetUtils.isCpf(cleanDoc)) {
        ShowToaster.toasterInfo(message: 'Digite um CPF Válido');
        return null;
      }
    } else {
      if (!GetUtils.isCnpj(cleanDoc)) {
        ShowToaster.toasterInfo(message: 'Digite um CNPJ Válido');
        return null;
      }
    }

    isLoading(true);
    try {
      final response = await AuthRepository().verifyAccount(
        document: cleanDoc,
      );

      if (response != null) {
        AppLogger.I().info('Auth Verify Success');
        box.write('document', response.document);
        AppLogger.I().debug('Document ${response.document} saved at Storage');

        userRx.updateFromVerification(response);

        AuthRedirect.handleRedirect(response);
      }

      return response;
    } catch (e, s) {
      AppLogger.I().error('Auth Verify', e, s, {
        'document': document.text,
      });
      if (e is ApiException) {
        if (e.statusCode == 422) {
          Get.toNamed(AppRoutes.onboardingDocument);
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

  void lastLogin() async {
    final box = GetStorage();
    String? lastLogin =
        documentText.value.isEmpty ? box.read('document') : documentText.value;

    if (lastLogin != null) {
      AppLogger.I().debug('Last Login: $lastLogin');
      if (lastLogin.length == 11) {
        document.text = cpfMaskFormatter.maskText(lastLogin);
      } else if (lastLogin.length > 11) {
        document.text = cnpjMaskFormatter.maskText(lastLogin);
      } else {
        AppLogger.I().debug('Dont have Last Login');
      }
    }
  }
}
