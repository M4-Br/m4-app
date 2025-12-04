import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/formatters.dart';
import 'package:app_flutter_miban4/features/pix/keyManager/repository/pix_key_manager_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class PixAddNewKeyController extends BaseController {
  final selectedDropdown = RxnString();

  final selectedKeyType = ''.obs;
  final selectedKeyValue = ''.obs;

  final passwordController = TextEditingController();
  final isPasswordObscure = true.obs;
  final _secureStorage = const FlutterSecureStorage();

  final manualInputController = TextEditingController();

  final List<String> dropdownOptions = [
    'pix_randomKeyRegister'.tr,
    'CPF',
    'pix_phone'.tr,
    'Email',
  ];

  @override
  void onClose() {
    passwordController.dispose();
    manualInputController.dispose();
    super.onClose();
  }

  void onDropdownChanged(String? newValue) {
    selectedDropdown.value = newValue;
    selectedKeyType.value = '';
    selectedKeyValue.value = '';
  }

  void selectOption({required String type, required String value}) {
    if (selectedKeyType.value == type) {
      selectedKeyType.value = '';
      selectedKeyValue.value = '';
    } else {
      selectedKeyType.value = type;
      selectedKeyValue.value = value;
    }
  }

  void openManualEntrySheet(String type) {
    manualInputController.clear();

    String title = type == 'email' ? 'Novo E-mail' : 'Novo Celular';
    TextInputType keyboard =
        type == 'email' ? TextInputType.emailAddress : TextInputType.number;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 24),
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: manualInputController,
                keyboardType: keyboard,
                autofocus: true,
                inputFormatters: type == 'phone' ? [phoneFormatter] : [],
                decoration: InputDecoration(
                  labelText:
                      type == 'email' ? 'Digite o e-mail' : 'Digite o celular',
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor)),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _confirmManualInput(type),
                  child: Text('confirm'.tr.toUpperCase(),
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(Get.context!).viewInsets.bottom)),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _confirmManualInput(String type) {
    final value = manualInputController.text.trim();
    if (value.isEmpty) return;

    if (type == 'email' && !GetUtils.isEmail(value)) {
      ShowToaster.toasterInfo(message: 'E-mail inválido', isError: true);
      return;
    }

    if (type == 'phone' && value.length < 14) {
      ShowToaster.toasterInfo(message: 'Celular inválido', isError: true);
      return;
    }

    selectedKeyType.value = type;
    selectedKeyValue.value = value;

    Get.back();
    Future.delayed(const Duration(milliseconds: 200), () {
      openPasswordDialog();
    });
  }

  void backToManager() {
    Get.offNamed(AppRoutes.pixKeyManager);
  }

  void togglePassword() => isPasswordObscure.toggle();

  void openPasswordDialog() {
    if (selectedKeyType.value.isEmpty) {
      ShowToaster.toasterInfo(message: 'Selecione uma opção para cadastrar.');
      return;
    }

    passwordController.clear();
    isPasswordObscure.value = true;

    CustomDialogs.showWidgetDialog(
      title: 'password_insert'.tr,
      content: Obx(() => TextField(
            controller: passwordController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            obscureText: isPasswordObscure.value,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              counterText: '',
              suffixIcon: IconButton(
                onPressed: togglePassword,
                icon: Icon(
                  isPasswordObscure.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: secondaryColor,
                ),
              ),
            ),
          )),
      onConfirm: _verifyAndRegister,
    );
  }

  Future<void> _verifyAndRegister() async {
    final typedPassword = passwordController.text;
    if (typedPassword.isEmpty) return;

    final String? savedPassword =
        await _secureStorage.read(key: 'user_password');

    if (savedPassword != null && savedPassword == typedPassword) {
      Get.back();
      FocusManager.instance.primaryFocus?.unfocus();
      _registerKey();
    } else {
      ShowToaster.toasterInfo(message: 'Senha incorreta!', isError: true);
      passwordController.clear();
    }
  }

  Future<void> _registerKey() async {
    await executeSafe(() async {
      final key = selectedKeyValue.value;
      final type = selectedKeyType.value;

      final result = await PixKeyManagerRepository().createKey(key, type);

      if (result.success == true) {
        Get.back();
      }

      ShowToaster.toasterInfo(message: 'Chave cadastrada com sucesso!');
      Get.back();
    });
  }
}
