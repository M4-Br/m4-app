import 'package:app_flutter_miban4/core/config/auth/controller/user_rx.dart';
import 'package:app_flutter_miban4/core/config/auth/model/auth_login_request.dart';
import 'package:app_flutter_miban4/core/config/auth/repositories/auth_repository.dart';
import 'package:app_flutter_miban4/core/config/auth/service/auth_service.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/log/scope_config.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';

class AppLifecycleController extends GetxController
    with WidgetsBindingObserver {
  static const int _gracePeriodSeconds = 30;
  DateTime? _pausedTime;

  final LocalAuthentication _localAuth = LocalAuthentication();
  final _secureStorage = const FlutterSecureStorage();
  final _box = GetStorage();

  final RxBool isPrivacyEnabled = false.obs;
  bool _isAuthenticating = false;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_isAuthenticating) return;

    if (state == AppLifecycleState.paused) {
      if (!kIsWeb) {
        _pausedTime = DateTime.now();
        isPrivacyEnabled.value = true;
      }
    } else if (state == AppLifecycleState.inactive) {
      if (!kIsWeb) {
        isPrivacyEnabled.value = true;
      }
    } else if (state == AppLifecycleState.resumed) {
      isPrivacyEnabled.value = false;
      _handleAppResume();
    }
  }

  Future<void> _handleAppResume() async {
    _isAuthenticating = true;

    if (!AuthService.to.isLogged) {
      _isAuthenticating = false;
      return;
    }

    if (kIsWeb) {
      _pausedTime = null;
      _isAuthenticating = false;
      return;
    }

    if (_pausedTime != null) {
      final timeInBackground =
          DateTime.now().difference(_pausedTime!).inSeconds;
      if (timeInBackground < _gracePeriodSeconds) {
        _pausedTime = null;
        _isAuthenticating = false;
        return;
      }
    }

    await _requestBiometricAndRenew();
  }

  Future<void> _requestBiometricAndRenew() async {
    Get.dialog(
      const PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(child: AppLoading()),
        ),
      ),
      barrierDismissible: false,
    );

    try {
      final canCheck = await _localAuth.canCheckBiometrics;

      if (!canCheck) {
        _forceLogout();
        return;
      }

      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Toque para desbloquear e renovar sua sessão',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );

      if (didAuthenticate) {
        await _performSilentRenew();
      } else {
        _forceLogout();
      }
    } on PlatformException catch (e) {
      AppLogger.I().error('Erro Biometria Resume', e, StackTrace.current);
      _forceLogout();
    } catch (e) {
      _forceLogout();
    } finally {
      await Future.delayed(const Duration(milliseconds: 500));
      _isAuthenticating = false;
    }
  }

  Future<void> _performSilentRenew() async {
    try {
      final storedDoc = await _secureStorage.read(key: 'user_document');
      final storedPass = await _secureStorage.read(key: 'user_password');

      if (storedDoc == null || storedPass == null) {
        _forceLogout();
        return;
      }

      final auth = await AuthRepository().authLogin(
        loginRequest:
            AuthLoginRequest(document: storedDoc, password: storedPass),
      );

      if (auth.token.isNotEmpty) {
        _box.write('token', auth.token);
        AuthService.to.loginSuccess(auth.token);

        if (Get.isRegistered<UserRx>()) {
          Get.find<UserRx>().user.value = auth;
        }

        await ScopeConfig.setup(auth);

        AppLogger.I().info('Sessão renovada com sucesso via Biometria');

        if (Get.isDialogOpen ?? false) {
          Get.back();
        }

        _pausedTime = null;
      }
    } catch (e) {
      AppLogger.I().error('Falha ao renovar token', e, StackTrace.current);
      _forceLogout();
    }
  }

  void _forceLogout() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    AuthService.to.logout();
  }

  void setAuthenticating(bool value) {
    _isAuthenticating = value;
  }
}
