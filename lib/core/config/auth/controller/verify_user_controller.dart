import 'package:app_flutter_miban4/core/config/auth/controller/auth_redirect_controller.dart';
import 'package:app_flutter_miban4/core/config/auth/model/verify_user_response.dart';
import 'package:app_flutter_miban4/core/config/auth/repositories/auth_repository.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class VerifyAccountController extends GetxController {
  VerifyAccountController();

  var isLoading = false.obs;
  TextEditingController document = TextEditingController();
  final box = GetStorage();
  final formKey = GlobalKey<FormState>();

  @override
  onInit() {
    super.onInit();
    lastLogin();
  }

  Future<VerifyUserResponse?> authVerify() async {
    isLoading(true);
    try {
      final response = await AuthRepository().verifyAccount(
        document: document.text
            .replaceAll(".", "")
            .replaceAll("-", "")
            .replaceAll("/", ""),
      );

      if (response != null) {
        AppLogger.I().info('Auth Verify Success');
        box.write('document', response.document);
        AppLogger.I().debug('Document ${response.document} saved at Storage');

        AuthRedirect.handleRedirect(response);
      }

      return response;
    } catch (e, s) {
      AppLogger.I().error('Auth Verify', e, s, {
        'document': document.text,
      });
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  void lastLogin() async {
    final box = GetStorage();
    String? lastLogin = box.read('document');

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
