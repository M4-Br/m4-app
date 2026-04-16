import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class HealthPlansController extends BaseController {
  final _storage = GetStorage();

  final String _storageKey = 'mock_melife_contracted';
  final String _storagePlanKey = 'mock_melife_plan_name';

  final String _checkoutUrl = 'https://melife.com.br/#planos';

  Future<void> handleContractPlan(String planName) async {
    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 1));

    try {
      _storage.write(_storageKey, true);
      _storage.write(_storagePlanKey, planName);

      ShowToaster.toasterInfo(
          message: 'Redirecionando para pagamento seguro...');

      Get.until((route) => route.settings.name == AppRoutes.healthHome);

      await _openCheckoutPage(_checkoutUrl);
    } catch (e) {
      ShowToaster.toasterInfo(
          message: 'Erro ao processar a contratação', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _openCheckoutPage(String url) async {
    final uri = Uri.parse(url);
    if (kIsWeb) {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } else {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ShowToaster.toasterInfo(
            message: 'Não foi possível abrir o link de pagamento',
            isError: true);
      }
    }
  }
}
