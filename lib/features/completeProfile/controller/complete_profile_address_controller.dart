import 'package:app_flutter_miban4/core/config/consts/lists/brazilian_states_list.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_address_request.dart';
import 'package:app_flutter_miban4/features/completeProfile/repository/complete_profile_address_repository.dart';
import 'package:app_flutter_miban4/features/geral/repository/cep_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileAddressController extends BaseController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final cepEc = TextEditingController();
  final addressEc = TextEditingController();
  final numberEc = TextEditingController();
  final complementEc = TextEditingController();
  final neighborhoodEc = TextEditingController();
  final cityEc = TextEditingController();

  final isNoNumberChecked = false.obs;
  final selectedState = RxnString();
  final selectedResType = RxnString();

  String? _lastSearchedCep;

  final List<String> residentialTypes = [
    'address_type_own'.tr,
    'address_type_rent'.tr,
    'address_type_financed'.tr,
    'address_type_company'.tr,
    'address_type_parents'.tr
  ];

  @override
  void onInit() {
    super.onInit();
    cepEc.addListener(_onCepChanged);
  }

  @override
  void onClose() {
    cepEc.removeListener(_onCepChanged);
    cepEc.dispose();
    addressEc.dispose();
    numberEc.dispose();
    complementEc.dispose();
    neighborhoodEc.dispose();
    cityEc.dispose();
    super.onClose();
  }

  void _onCepChanged() {
    final text = cepEc.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.length == 8 && !isLoading.value) {
      if (_lastSearchedCep != text) {
        debugPrint('🔎 CEP Detectado: $text - Iniciando busca...');
        fetchCep(text);
      }
    }
  }

  void toggleNoNumber(bool? value) {
    isNoNumberChecked.value = value ?? false;
    if (isNoNumberChecked.value) {
      numberEc.clear();
    }
  }

  Future<void> fetchCep(String rawCep) async {
    String cleanCep = rawCep.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanCep.length != 8) return;

    _lastSearchedCep = cleanCep;

    await executeSafe(() async {
      AppLogger.I().info('🚀 Chamando API ViaCep/Repository para: $cleanCep');

      final cep = await CepRepository().fetchCep(cleanCep);

      AppLogger.I()
          .info('✅ Retorno da API: ${cep.logradouro}, ${cep.localidade}');

      addressEc.text = cep.logradouro;
      neighborhoodEc.text = cep.bairro;
      cityEc.text = cep.localidade;

      if (BrazilianStates.abbreviations.contains(cep.uf)) {
        selectedState.value = cep.uf;
      } else {
        selectedState.value = null;
      }
    }, message: 'Digite um CEP Válido');
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    if (selectedResType.value == null) {
      ShowToaster.toasterInfo(message: 'Selecione o tipo de residência');
      return;
    }

    if (selectedState.value == null) {
      ShowToaster.toasterInfo(message: 'Selecione o estado');
      return;
    }

    await executeSafe(() async {
      String postalCode = cepEc.text.replaceAll(RegExp(r'[^0-9]'), '');
      String typeId = _mapResidentialTypeToId(selectedResType.value ?? '');

      final result = await CompleteProfileAddressRepository().sendAddress(
          CompleteProfileAddressRequest(
              individualId: userRx.user.value!.payload.id,
              postalCode: postalCode,
              type: typeId,
              street: addressEc.text,
              number: isNoNumberChecked.value ? '' : numberEc.text,
              neighborhood: neighborhoodEc.text,
              complement: complementEc.text,
              state: selectedState.value!,
              city: cityEc.text));

      final addressStep =
          result.steps.firstWhereOrNull((step) => step.stepId == 3);

      if (addressStep != null && addressStep.done) {
        Get.toNamed(AppRoutes.completeProfession);
      }
    });
  }

  String _mapResidentialTypeToId(String type) {
    if (type == 'address_type_own'.tr || type == 'Own') return '1';
    if (type == 'address_type_rent'.tr || type == 'Rent') return '2';
    if (type == 'address_type_financed'.tr || type == 'Financed') return '3';
    if (type == 'address_type_company'.tr || type == 'Company') return '4';
    if (type == 'address_type_parents'.tr || type == 'with parents') return '5';
    return '1';
  }
}
