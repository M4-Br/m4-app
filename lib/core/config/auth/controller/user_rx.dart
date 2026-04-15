import 'package:app_flutter_miban4/core/config/auth/model/user.dart';
import 'package:app_flutter_miban4/core/config/auth/model/verify_user_response.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:get/get.dart';

class UserRx extends GetxController {
  Rx<User?> user = Rx<User?>(null);

  Rx<VerifyUserResponse?> verifyResponse = Rx<VerifyUserResponse?>(null);

  DateTime? lastTokenSentTime;

  String get userEmail {
    return user.value?.payload.email ?? verifyResponse.value?.email ?? '';
  }

  int? get userId {
    return user.value?.payload.userId ?? verifyResponse.value?.userData?.id;
  }

  int? get individualId {
    return user.value?.payload.id ?? verifyResponse.value?.id;
  }

  List<Steps> get userSteps {
    return user.value?.payload.steps ?? verifyResponse.value?.steps ?? [];
  }

  Company? get company {
    return user.value?.payload.company;
  }

  String? get cnpj {
    return company?.document;
  }

  String? get companyName {
    return company?.tradeName;
  }

  void updateFromVerification(VerifyUserResponse response) {
    verifyResponse.value = response;

    if (user.value != null) {
      final newPayload = user.value!.payload.copyWith(
        userId: response.userData?.id,
        email: response.email,
        steps: response.steps,
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
    lastTokenSentTime = null;
  }
}
