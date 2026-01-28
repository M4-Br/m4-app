import 'package:app_flutter_miban4/core/config/auth/model/user.dart';
import 'package:app_flutter_miban4/core/config/auth/model/verify_user_response.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:get/get.dart';

class UserRx extends GetxController {
  Rx<User?> user = Rx<User?>(null);

  Rx<VerifyUserResponse?> verifyResponse = Rx<VerifyUserResponse?>(null);

  String get userEmail {
    return user.value?.payload.email ?? verifyResponse.value?.email ?? '';
  }

  int? get userId {
    return user.value?.payload.userId ?? verifyResponse.value?.userData.id;
  }

  void updateFromVerification(VerifyUserResponse response) {
    verifyResponse.value = response;
    if (user.value != null) {
      final newPayload = user.value!.payload.copyWith(
        userId: response.userData.id,
        email: response.email,
      );

      user.value = user.value!.copyWith(payload: newPayload);
      user.refresh();
    }
  }

  void handleUnauthenticatedUser() {
    if (Get.isDialogOpen == false && Get.isSnackbarOpen == false) {
      CustomDialogs.showInformationDialog(
        content: 'Usuário não autenticado. Faça o Login novamente',
        onCancel: () => Get.offAllNamed(AppRoutes.splash),
      );
    }
  }

  void clear() {
    user.value = null;
    verifyResponse.value = null;
  }
}
