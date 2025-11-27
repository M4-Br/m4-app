import 'package:app_flutter_miban4/core/config/auth/controller/auth_redirect_controller.dart';
import 'package:app_flutter_miban4/core/config/auth/model/verify_user_response.dart';
import 'package:app_flutter_miban4/core/config/auth/repositories/auth_repository.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class VerifyAccountController extends GetxController {
  VerifyAccountController();

  final RxString documentText = ''.obs;

  var isLoading = false.obs;
  TextEditingController document = TextEditingController();
  final box = GetStorage();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      documentText.value = arguments['document'] ?? '';
    }
    lastLogin();
  }

  Future<VerifyUserResponse?> authVerify() async {
    if (!formKey.currentState!.validate()) {
      return null;
    }

    isLoading(true);
    try {
      final response = await AuthRepository().verifyAccount(
        document: document.text
            .replaceAll('.', '')
            .replaceAll('-', '')
            .replaceAll('/', ''),
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
