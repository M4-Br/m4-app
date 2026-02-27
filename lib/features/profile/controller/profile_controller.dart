import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/completeProfile/controller/redirect_complete_profile_controller.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_response.dart';
import 'package:app_flutter_miban4/features/completeProfile/repository/complete_profile_verify_steps_repository.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileController extends BaseController {
  final RedirectCompleteProfileController redirect;
  ProfileController(this.redirect);

  final steps = Rxn<CompleteProfileResponse>();

  final appVersion = ''.obs;

  @override
  void onInit() {
    fetchSteps();
    _loadVersion();
    super.onInit();
  }

  Future<void> fetchSteps() async {
    await executeSafe(() async {
      final currentUser = userRx.user.value;
      if (currentUser == null || currentUser.payload.document.isEmpty) {
        steps.value = null;
        return;
      }

      final result = await CompleteProfileVerifyStepsRepository()
          .fetchProfileSteps(currentUser.payload.document);

      steps.value = result;
    });
  }

  Future<void> redirectToCompleteProfile() async {
    await fetchSteps();

    if (steps.value != null) {
      await redirect.handleRedirect(steps.value!);
    }
  }

  bool get showCompleteProfileOption {
    if (steps.value == null) return false;

    return steps.value!.steps.any((step) {
      return step.stepId >= 3 && step.stepId <= 8 && !step.done;
    });
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = '${packageInfo.version} (${packageInfo.buildNumber})';
  }
}
