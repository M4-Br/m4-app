import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_profession_request.dart';
import 'package:app_flutter_miban4/features/completeProfile/repository/complete_profile_profession_repository.dart';
import 'package:app_flutter_miban4/features/geral/model/professions_response.dart';
import 'package:app_flutter_miban4/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileProfessionController extends BaseController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final incomeEc = TextEditingController(text: '0,00');

  final selectedProfession = Rxn<ProfessionsResponse>();

  @override
  void onClose() {
    incomeEc.dispose();
    super.onClose();
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    if (selectedProfession.value == null) {
      ShowToaster.toasterInfo(
          message: 'Selecione sua profissão para continuar');
      return;
    }

    await executeSafe(() async {
      String rawIncome = incomeEc.text.replaceAll(RegExp(r'[^0-9]'), '');

      if (rawIncome.isEmpty) rawIncome = '0';

      String professionId = selectedProfession.value!.id.toString();

      final result = await CompleteProfileProfessionRepository().sendProfession(
          CompleteProfileProfessionRequest(
              id: userRx.user.value!.payload.id,
              professionId: professionId,
              income: rawIncome));

      final professionStep =
          result.steps.firstWhereOrNull((step) => step.stepId == 4);

      if (Get.isRegistered<ProfileController>()) {
        Get.find<ProfileController>().fetchSteps();
      }

      if (professionStep != null && professionStep.done == true) {
        Get.toNamed(AppRoutes.completePersonalData);
      }
    });
  }
}
