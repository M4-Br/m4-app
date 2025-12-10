import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/formatters.dart';
import 'package:app_flutter_miban4/features/pix/keyManager/model/pix_key_response.dart';
import 'package:app_flutter_miban4/features/pix/keyManager/repository/pix_key_manager_repository.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PixKeyManagerController extends BaseController {
  final Rx<PixKeyResponse?> pixKeysData = Rx<PixKeyResponse?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchKeys();
  }

  Future<void> fetchKeys() async {
    await executeSafe(() async {
      final result = await PixKeyManagerRepository().fetchKeys();

      pixKeysData.value = result;
    });
  }

  void goToAddKey() async {
    Get.toNamed(AppRoutes.pixNewKey);
  }

  Future<void> deleteKey(String key) async {
    Get.back();

    await executeSafe(() async {
      await PixKeyManagerRepository().deleteKey(key);

      await fetchKeys();

      CustomDialogs.showInformationDialog(
        content: 'Chave removida com sucesso!',
        onCancel: () => Get.back(),
      );
    });
  }

  String formatKey(String key, String type) {
    if (type == 'phone') return phoneFormatter.maskText(key);
    if (type == 'document') {
      return key.length > 11
          ? cnpjFormatter.maskText(key)
          : cpfFormatter.maskText(key);
    }
    return key;
  }

  void copyKeyToClipboard(String key) {
    Clipboard.setData(ClipboardData(text: key));
    ShowToaster.toasterInfo(message: 'pix_keyCopied'.tr);
  }
}
