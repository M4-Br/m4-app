import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/maks_apply.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/geral/controller/favorites_transfers_controller.dart';
import 'package:app_flutter_miban4/features/geral/model/favorites_response.dart';
import 'package:app_flutter_miban4/features/pix/pixWithKey/repository/pix_with_key_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PixWithKeyController extends BaseController {
  final FavoritesTransfersController fav;
  PixWithKeyController(this.fav);

  final PixWithKeyRepository _pixRepo = PixWithKeyRepository();
  final keyController = TextEditingController();

  final isButtonEnabled = false.obs;
  final detectedLabel = ''.obs;

  String? _detectedTypeBackend;

  final Map<String, String> keyTypesLabels = {
    'EVP': 'Chave Aleatória',
    'EMAIL': 'Email',
    'PHONE': 'Celular',
    'DOCUMENT': 'CPF/CNPJ',
  };

  @override
  void onInit() {
    super.onInit();
    keyController.addListener(_onTextChanged);
    fav.getFavorites();
  }

  @override
  void onClose() {
    keyController.removeListener(_onTextChanged);
    keyController.dispose();
    super.onClose();
  }

  void _onTextChanged() {
    _detectAndValidate(keyController.text);
  }

  void _detectAndValidate(String text) {
    if (text.isEmpty) {
      _resetState();
      return;
    }

    if (text.contains('@')) {
      if (GetUtils.isEmail(text.trim())) {
        _setValidState('E-mail válido', 'EMAIL');
      } else {
        _setInvalidState('Digitando e-mail...');
      }
      return;
    }

    final cleanText = text.replaceAll(RegExp(r'[^0-9a-zA-Z]'), '');
    final onlyNumbers = text.replaceAll(RegExp(r'[^0-9]'), '');
    final hasLetters = text.contains(RegExp(r'[a-zA-Z]'));

    if (hasLetters) {
      if (cleanText.length >= 32) {
        _setValidState('Chave Aleatória', 'EVP');
      } else {
        _setInvalidState('Chave Aleatória (incompleta)');
      }
      return;
    }

    if (onlyNumbers.isNotEmpty && !hasLetters) {
      if (onlyNumbers.length == 11) {
        if (GetUtils.isCpf(onlyNumbers)) {
          _setValidState('CPF Detectado', 'DOCUMENT');
        } else {
          _setValidState('Celular Detectado', 'PHONE');
        }
        return;
      }

      if (onlyNumbers.length == 14) {
        if (GetUtils.isCnpj(onlyNumbers)) {
          _setValidState('CNPJ Detectado', 'DOCUMENT');
        } else {
          _setInvalidState('CNPJ Inválido');
        }
        return;
      }

      if (onlyNumbers.length < 11) {
        _setInvalidState('Digitando números...');
      } else if (onlyNumbers.length > 14) {
        _setInvalidState('Número inválido');
      } else {
        _setInvalidState('Verificando...');
      }
      return;
    }

    _resetState();
  }

  void _setValidState(String label, String type) {
    detectedLabel.value = label;
    _detectedTypeBackend = type;
    isButtonEnabled.value = true;
  }

  void _setInvalidState(String label) {
    detectedLabel.value = label;
    _detectedTypeBackend = null;
    isButtonEnabled.value = false;
  }

  void _resetState() {
    detectedLabel.value = '';
    _detectedTypeBackend = null;
    isButtonEnabled.value = false;
  }

  TextInputFormatter get smartMaskFormatter => SmartPixMaskFormatter();

  Color get buttonColor => isButtonEnabled.value ? secondaryColor : Colors.grey;

  Future<void> searchKey() async {
    if (!isButtonEnabled.value || _detectedTypeBackend == null) return;

    String rawKey = keyController.text.trim();
    if (_detectedTypeBackend == 'DOCUMENT' || _detectedTypeBackend == 'PHONE') {
      rawKey = rawKey.replaceAll(RegExp(r'[^0-9]'), '');
    }

    await _executeValidation(rawKey, _detectedTypeBackend!);
  }

  void onFavoriteSelected(FavoriteContactModel favorite) {
    if (favorite.pixKeys.isEmpty) {
      ShowToaster.toasterInfo(message: 'Este contato não possui chaves Pix.');
      return;
    }

    if (favorite.pixKeys.length == 1) {
      final k = favorite.pixKeys.first;
      _executeValidation(k.key, k.type);
      return;
    }

    _showSelectKeyDialog(favorite);
  }

  void _showSelectKeyDialog(FavoriteContactModel favorite) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Escolha a chave de ${favorite.nickname}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 16),
            ...favorite.pixKeys.map((k) => ListTile(
                  title: Text(k.key),
                  subtitle: Text(keyTypesLabels[k.type] ?? k.type),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Get.back();
                    _executeValidation(k.key, k.type);
                  },
                )),
            const SizedBox(height: 20),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Future<void> _executeValidation(String key, String type) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await executeSafe(() async {
      final keyValidated = await _pixRepo.validateKey(key);

      if (keyValidated.success == true) {
        Get.toNamed(AppRoutes.pixTransfer,
            arguments: {'key': keyValidated, 'type': type});
      }
    });
  }

  void backToHome() {
    Get.back();
  }
}
