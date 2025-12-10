import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/appTerms/repository/terms_repository.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:get/get.dart';

class TermsController extends GetxController {
  final RxString termsHtmlContent = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTerms();
  }

  Future<void> fetchTerms() async {
    isLoading(true);

    try {
      final result = await TermsRepository().fetchTerms();

      termsHtmlContent.value = result.text;
    } catch (e, s) {
      AppLogger.I().error('Fetch terms', e, s);
      ShowToaster.toasterInfo(message: 'Conteúdo vazio');
    } finally {
      isLoading(false);
    }
  }
}
