import 'package:app_flutter_miban4/core/config/auth/model/user.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:get/get.dart';

class UserRx extends GetxController {
  Rx<User?> user = Rx<User?>(null);

  void handleUnauthenticatedUser() {
    if (Get.isDialogOpen == false && Get.isSnackbarOpen == false) {
      CustomDialogs.showInformationDialog(
        content: 'Usuário não autenticado. Faça o Login novamente',
        onCancel: () => Get.offAllNamed(AppRoutes.splash),
      );
    }
  }
}
