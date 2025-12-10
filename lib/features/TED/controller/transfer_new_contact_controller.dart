import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/TED/model/transfer_user_response.dart';
import 'package:app_flutter_miban4/features/TED/repository/transfer_new_contact_repository.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferNewContactController extends BaseController {
  final documentController = TextEditingController();

  @override
  void onClose() {
    documentController.dispose();
    super.onClose();
  }

  Future<void> onNext() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final document = documentController.text
        .replaceAll('.', '')
        .replaceAll('-', '')
        .replaceAll('/', '')
        .trim();

    if (document.isEmpty) {
      ShowToaster.toasterInfo(message: 'Digite o CPF ou CNPJ', isError: true);
      return;
    }

    if (!document.isCpf && !document.isCnpj) {
      ShowToaster.toasterInfo(message: 'Documento inválido', isError: true);
      return;
    }

    if (document == userRx.user.value?.payload.document) {
      ShowToaster.toasterInfo(
          message: 'Você não pode transferir para si mesmo por aqui.',
          isError: true);
      return;
    }

    await executeSafe(() async {
      final result = await TransferNewContactRepository().fetchUser(document);

      if (result.id != 0) {
        _goToBankChoose(result);
      }
    });
  }

  void _goToBankChoose(TransferUserResponse result) {
    Get.toNamed(AppRoutes.transferBank, arguments: result);
  }
}
