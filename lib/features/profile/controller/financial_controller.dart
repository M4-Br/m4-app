import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/features/profile/data/financial_params_repository.dart';
import 'package:app_flutter_miban4/features/profile/model/capacity_response.dart';
import 'package:app_flutter_miban4/features/profile/model/params_reponse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinancialController extends BaseController {
  FinancialController();

  final _repository = FinancialParamsRepository();

  final Rx<ParamsReponse?> userParams = Rx<ParamsReponse?>(null);
  final Rx<CapacityResponse?> userCapacity = Rx<CapacityResponse?>(null);

  final RxnString selectedHomeType = RxnString(null);
  final RxnString selectedTransport = RxnString(null);

  final RxBool isButtonEnabled = false.obs;
  final RxBool isPosting = false.obs;

  final TextEditingController incomeController = TextEditingController();
  final TextEditingController familySizeController = TextEditingController();
  final TextEditingController houseCostsController = TextEditingController();
  final TextEditingController transportCostsController =
      TextEditingController();
  final TextEditingController utilityCostsController = TextEditingController();
  final TextEditingController otherCostsController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    _addTextFieldListeners();

    _fetchInitialData();
  }

  @override
  void onClose() {
    incomeController.dispose();
    familySizeController.dispose();
    houseCostsController.dispose();
    transportCostsController.dispose();
    utilityCostsController.dispose();
    otherCostsController.dispose();
    super.onClose();
  }

  Future<void> _fetchInitialData() async {
    await executeSafe(() async {
      final futures = [
        fetchFinancialParams(),
        fetchFinancialCapacity(),
      ];
      await Future.wait(futures);
      _populateFieldsFromData();
    }, message: 'Erro ao obter dados financeiros');
  }

  Future<void> fetchFinancialParams() async {
    final financialParams = await _repository.fetchFinancial();
    AppLogger.I().debug('Financial Params fetched');
    userParams.value = financialParams;
  }

  Future<void> fetchFinancialCapacity() async {
    final userId = userRx.user.value!.payload.id.toString();

    final financialCapacity = await _repository.fetchCapacity(userId: userId);
    AppLogger.I().debug('Financial Capacity fetched');
    userCapacity.value = financialCapacity;
  }

  void _populateFieldsFromData() {
    final capacity = userCapacity.value;
    if (capacity == null) return;
    incomeController.text = capacity.incomeFamily.toString();
    houseCostsController.text = capacity.houseCost.centsToBRL();
    transportCostsController.text = capacity.transportCost.centsToBRL();
    utilityCostsController.text = capacity.utilitiesCost.centsToBRL();
    otherCostsController.text = capacity.otherCost.centsToBRL();

    selectedHomeType.value = capacity.house;
    selectedTransport.value = capacity.transport;
    _checkIfAllFieldsAreFilled();
  }

  List<DropdownMenuItem<String>> get dropdownHouse {
    if (userParams.value == null) return [];

    return userParams.value!.home.map((option) {
      return DropdownMenuItem<String>(
        value: option.value,
        child: Text(option.label),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> get dropdownTransport {
    if (userParams.value == null) return [];

    return userParams.value!.transport.map((option) {
      return DropdownMenuItem<String>(
        value: option.value,
        child: Text(option.label),
      );
    }).toList();
  }

  void _addTextFieldListeners() {
    incomeController.addListener(_checkIfAllFieldsAreFilled);
    familySizeController.addListener(_checkIfAllFieldsAreFilled);
    houseCostsController.addListener(_checkIfAllFieldsAreFilled);
    transportCostsController.addListener(_checkIfAllFieldsAreFilled);
    utilityCostsController.addListener(_checkIfAllFieldsAreFilled);
    otherCostsController.addListener(_checkIfAllFieldsAreFilled);
  }

  void _checkIfAllFieldsAreFilled() {
    isButtonEnabled.value = incomeController.text.isNotEmpty &&
        familySizeController.text.isNotEmpty &&
        houseCostsController.text.isNotEmpty &&
        transportCostsController.text.isNotEmpty &&
        utilityCostsController.text.isNotEmpty &&
        otherCostsController.text.isNotEmpty;
  }

  // // --- AÇÕES DO USUÁRIO ---

  // /// Salva os dados financeiros
  // Future<void> postFinancial(String? groupID) async {
  //   isPosting.value = true;

  //   // Traz a lógica do seu _postFinancial para cá
  //   await executeSafe(() async {
  //     String groupId = groupID ?? '';
  //     int incomeValue =
  //         int.parse(incomeController.text.replaceAll(RegExp(r'[^0-9]'), ''));
  //     String peopleFamily = familySizeController.text;
  //     String house = selectedHomeType.value.toString();
  //     String transport = selectedTransport.value.toString();
  //     int houseCostValue = int.parse(
  //         houseCostsController.text.replaceAll(RegExp(r'[^0-9]'), ''));
  //     int transportCostValue = int.parse(
  //         transportCostsController.text.replaceAll(RegExp(r'[^0-9]'), ''));
  //     int utilitiesCostValue = int.parse(
  //         utilityCostsController.text.replaceAll(RegExp(r'[^0-9]'), ''));
  //     int otherCostsValue = int.parse(
  //         otherCostsController.text.replaceAll(RegExp(r'[^0-9]'), ''));

  //     String income = (incomeValue / 100).toString();
  //     String houseCost = (houseCostValue / 100).toString();
  //     String transportCost = (transportCostValue / 100).toString();
  //     String utilitiesCost = (utilitiesCostValue / 100).toString();
  //     String otherCosts = (otherCostsValue / 100).toString();

  //     await SharedPreferencesFunctions.saveString(
  //         key: 'familySize', value: peopleFamily);

  //     // *** IMPORTANTE ***
  //     // Você estava usando _financialDataController.financialData(...)
  //     // O correto é usar seu repositório.
  //     // Tive que "adivinhar" o nome do método, ajuste se necessário.
  //     await _repository.postFinancialData(
  //       groupId: groupId,
  //       income: income,
  //       peopleFamily: peopleFamily,
  //       house: house,
  //       transport: transport,
  //       houseCost: houseCost,
  //       transportCost: transportCost,
  //       utilitiesCost: utilitiesCost,
  //       otherCosts: otherCosts,
  //     );

  //     // Se chegou aqui, deu certo
  //     Get.snackbar('Sucesso', 'Dados financeiros atualizados.');
  //     Get.back(); // Volta a tela anterior
  //   }, message: 'Erro ao salvar dados financeiros');

  //   isPosting.value = false;
  // }
}
