import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/appTerms/repository/privacy_policy_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController {
  final RxString policyHtmlContent = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPrivacePolicy();
  }

  Future<void> fetchPrivacePolicy() async {
    isLoading(true);

    try {
      final result = await PrivacyPolicyRepository().fetchPrivacyPolicy();

      policyHtmlContent.value = result.text;
    } catch (e, s) {
      AppLogger.I().error('Fetch privacy policy', e, s);
      ShowToaster.toasterInfo(message: 'Conteúdo vazio');
    } finally {
      isLoading(false);
    }
  }
}
