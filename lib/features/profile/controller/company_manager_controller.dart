import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyManagerController extends BaseController {
  final RxString selectedFileName = ''.obs;
  final RxBool isReplacingDocument = false.obs; // <--- NOVA FLAG

  // Controladores para o Modal de Cadastro
  final cnpjController = TextEditingController();
  final razaoSocialController = TextEditingController();
  final nomeFantasiaController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void onClose() {
    cnpjController.dispose();
    razaoSocialController.dispose();
    nomeFantasiaController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void pickPdfFile() async {
    await executeSafe(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      selectedFileName.value = 'Cartao_CNPJ_Atualizado.pdf';
      ShowToaster.toasterInfo(message: 'Novo documento selecionado!');
    }, message: 'Erro ao selecionar o arquivo');
  }

  void removePdfFile() {
    selectedFileName.value = '';
  }

  // Alterna para o modo de substituição
  void toggleReplaceMode() {
    isReplacingDocument.value = true;
  }

  void cancelReplacement() {
    isReplacingDocument.value = false;
    selectedFileName.value = '';
  }

  Future<void> uploadPdf() async {
    if (selectedFileName.value.isEmpty) return;

    await executeSafe(() async {
      await Future.delayed(const Duration(seconds: 2));

      ShowToaster.toasterInfo(message: 'Documento atualizado com sucesso!');
      selectedFileName.value = '';
      isReplacingDocument.value = false; // Sai do modo de troca
    }, message: 'Erro ao enviar o novo documento');
  }

  // Simulação de cadastro de nova empresa
  Future<void> submitNewCompany() async {
    if (cnpjController.text.isEmpty || razaoSocialController.text.isEmpty) {
      ShowToaster.toasterInfo(
          message: 'Preencha os dados obrigatórios.', isError: true);
      return;
    }
    if (selectedFileName.value.isEmpty) {
      ShowToaster.toasterInfo(message: 'Anexe o Cartão CNPJ.', isError: true);
      return;
    }

    await executeSafe(() async {
      await Future.delayed(const Duration(seconds: 2));
      Get.back();
      ShowToaster.toasterInfo(message: 'Empresa cadastrada com sucesso!');
      _clearFields();
    }, message: 'Erro ao cadastrar empresa');
  }

  void _clearFields() {
    cnpjController.clear();
    razaoSocialController.clear();
    nomeFantasiaController.clear();
    emailController.clear();
    phoneController.clear();
    selectedFileName.value = '';
  }

  void viewCurrentPdf() {
    ShowToaster.toasterInfo(message: 'Abrindo visualizador do PDF atual...');
  }
}
