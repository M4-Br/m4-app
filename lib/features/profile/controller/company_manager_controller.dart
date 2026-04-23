import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/profile/model/company_register_model.dart';
import 'package:app_flutter_miban4/features/profile/repository/company_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyManagerController extends BaseController {
  final CompanyRepository _repository = CompanyRepository();
  final Rx<CompanyRegisterModel?> currentCompany = Rx<CompanyRegisterModel?>(null);

  // Controladores para o Modal de Cadastro
  final cnpjController = TextEditingController();
  final razaoSocialController = TextEditingController();
  final nomeFantasiaController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCompanyData();
  }

  Future<void> fetchCompanyData() async {
    final userId = userRx.userId;
    if (userId == null) return;

    await executeSafe(() async {
      final fetched = await _repository.fetchCompany(userId);
      currentCompany.value = fetched;
    }, message: 'Erro ao buscar dados da empresa', showErrorToast: false);
  }

  // Cadastro de nova empresa
  Future<void> submitNewCompany() async {
    if (cnpjController.text.isEmpty || razaoSocialController.text.isEmpty) {
      ShowToaster.toasterInfo(
          message: 'Preencha os dados obrigatórios.', isError: true);
      return;
    }

    await executeSafe(() async {
      final model = CompanyRegisterModel(
        name: razaoSocialController.text,
        document: cnpjController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        tradeName: nomeFantasiaController.text.isNotEmpty ? nomeFantasiaController.text : razaoSocialController.text,
        email: emailController.text,
        phone: phoneController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        status: 'inactive',
      );

      await _repository.registerCompany(model);

      Get.back();
      ShowToaster.toasterInfo(message: 'Empresa cadastrada com sucesso!');
      _clearFields();
      fetchCompanyData();
    }, message: 'Erro ao cadastrar empresa');
  }

  void _clearFields() {
    cnpjController.clear();
    razaoSocialController.clear();
    nomeFantasiaController.clear();
    emailController.clear();
    phoneController.clear();
  }

  @override
  void onClose() {
    cnpjController.dispose();
    razaoSocialController.dispose();
    nomeFantasiaController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
