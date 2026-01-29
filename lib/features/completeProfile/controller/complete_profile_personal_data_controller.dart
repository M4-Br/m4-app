import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_personal_data_request.dart';
import 'package:app_flutter_miban4/features/completeProfile/repository/complete_profile_personal_data_repository.dart';
import 'package:app_flutter_miban4/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CompleteProfilePersonalDataController extends BaseController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nameEc = TextEditingController();
  final motherNameEc = TextEditingController();
  final birthDateEc = TextEditingController();
  final rgNumberEc = TextEditingController();
  final rgIssuerEc = TextEditingController();
  final rgDateEc = TextEditingController();
  final pepDateEc = TextEditingController();

  final selectedGender = RxnString();
  final selectedMaritalStatus = RxnString();
  final selectedNationality = RxnString();
  final selectedRgState = RxnString();

  final selectedPepOption = RxnString();
  final isPep = false.obs;

  final genderOptions = [
    'gender_male'.tr,
    'gender_female'.tr,
    'gender_another'.tr,
    'gender_notDefined'.tr
  ];

  final maritalOptions = [
    'marital_status_single'.tr,
    'marital_status_married'.tr,
    'marital_status_legally_separated'.tr,
    'marital_status_widowed'.tr,
    'marital_status_cohabitant'.tr,
    'marital_status_separated'.tr
  ];

  final nationalityOptions = [
    'nationality_brazilian'.tr,
    'nationality_foreigner'.tr
  ];

  final pepOptions = ['pep_no'.tr, 'pep_yes'.tr];

  @override
  void onClose() {
    nameEc.dispose();
    motherNameEc.dispose();
    birthDateEc.dispose();
    rgNumberEc.dispose();
    rgIssuerEc.dispose();
    rgDateEc.dispose();
    pepDateEc.dispose();
    super.onClose();
  }

  void setPepOption(String? value) {
    selectedPepOption.value = value;
    if (value == 'pep_yes'.tr) {
      isPep.value = true;
    } else {
      isPep.value = false;
      pepDateEc.clear();
    }
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    if (selectedGender.value == null ||
        selectedMaritalStatus.value == null ||
        selectedNationality.value == null ||
        selectedRgState.value == null) {
      ShowToaster.toasterInfo(message: 'Preencha todos os campos de seleção');
      return;
    }

    await executeSafe(() async {
      String formattedBirth = _formatDateToApi(birthDateEc.text);
      String formattedRgDate = _formatDateToApi(rgDateEc.text);
      String formattedPepDate =
          isPep.value ? _formatDateToApi(pepDateEc.text) : '';

      String cleanRg = rgNumberEc.text.replaceAll('.', '').replaceAll('-', '');

      String genderValue = selectedGender.value![0];

      final result = await CompleteProfilePersonalDataRepository()
          .sendPersonalData(CompleteProfilePersonalDataRequest(
              id: userRx.individualId!.toString(),
              username: nameEc.text,
              documentState: selectedRgState.value.toString(),
              documentNumber: cleanRg,
              motherName: motherNameEc.text,
              gender: genderValue,
              birthDate: formattedBirth,
              maritalStatus: selectedMaritalStatus.value.toString(),
              nationality: selectedNationality.value.toString(),
              issuanceDate: formattedRgDate));

      final personalDataStep =
          result.steps.firstWhereOrNull((step) => step.stepId == 5);

      if (personalDataStep!.done == true) {
        if (Get.isRegistered<ProfileController>()) {
          Get.find<ProfileController>().fetchSteps();
        }

        Get.toNamed(AppRoutes.completeDocumentChoose);
      }
    });
  }

  String _formatDateToApi(String date) {
    if (date.length != 10) return '';
    try {
      final parsed = DateFormat('dd/MM/yyyy').parse(date);
      return DateFormat('yyyy-MM-dd').format(parsed);
    } catch (e) {
      return '';
    }
  }
}
