import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/geral/controller/favorites_controller.dart';
import 'package:app_flutter_miban4/features/pix/pixWithKey/repository/pix_with_key_repository.dart';
import 'package:get/get.dart';

class AiActionHandler {
  static Future<void> handle(Map<String, dynamic> aiResponse) async {
    final type = aiResponse['type'];
    final message = aiResponse['message'];

    switch (type) {
      case 'NAVIGATION':
        if (aiResponse['target'] != null) {
          Get.toNamed(aiResponse['target']);
        }
        break;

      case 'TRANSFER_ATTEMPT':
        await _handleTransfer(aiResponse['name'], aiResponse['amount']);
        break;

      case 'UNKNOWN':
        if (message != null) ShowToaster.toasterInfo(message: message);
        break;
    }
  }

  static Future<void> _handleTransfer(String targetName, String? amount) async {
    if (!Get.isRegistered<FavoritesController>()) {
      ShowToaster.toasterInfo(
          message: 'Erro interno: Favoritos não carregados.');
      return;
    }

    final favController = Get.find<FavoritesController>();
    final list = favController.favoritesList;

    final favorite = list.firstWhereOrNull((f) =>
        f.nickname.toLowerCase().contains(targetName.toLowerCase()) ||
        f.fullName.toLowerCase().contains(targetName.toLowerCase()));

    if (favorite == null) {
      ShowToaster.toasterInfo(
          message: 'Não encontrei "$targetName" nos seus favoritos.');
      return;
    }

    if (favorite.pixKeys.isEmpty) {
      ShowToaster.toasterInfo(
          message: '${favorite.nickname} não tem chaves Pix salvas.');
      return;
    }

    final keyToUse = favorite.pixKeys.first;

    ShowToaster.toasterInfo(
        message: 'Validando chave de ${favorite.nickname}...');

    try {
      final repo = PixWithKeyRepository();
      final validatedKey = await repo.validateKey(keyToUse.key);

      if (validatedKey.success == true) {
        Get.toNamed(AppRoutes.pixTransfer, arguments: {
          'key': validatedKey,
          'type': keyToUse.type,
          'prefilledAmount': amount
        });
      } else {
        ShowToaster.toasterInfo(
            message: 'Erro ao validar a chave do contato.', isError: true);
      }
    } catch (e) {
      ShowToaster.toasterInfo(message: 'Falha na conexão.', isError: true);
    }
  }
}
