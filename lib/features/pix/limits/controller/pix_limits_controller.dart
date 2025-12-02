import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/pix/limits/model/pix_limits_response.dart';
import 'package:app_flutter_miban4/features/pix/limits/repository/pix_limits_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PixLimitsController extends BaseController {
  final Rx<PixLimitsResponse?> pixLimits = Rx<PixLimitsResponse?>(null);

  final _currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void onInit() {
    super.onInit();
    fetchLimits();
  }

  Future<void> fetchLimits() async {
    await executeSafe(() async {
      final limits = await PixLimitsRepository().fetchLimits();

      pixLimits.value = limits;
    });
  }

  String formatCurrency(String rawValue) {
    try {
      final doubleValue = double.tryParse(rawValue) ?? 0.0;
      return _currencyFormat.format(doubleValue / 100);
    } catch (e) {
      return 'R\$ --,--';
    }
  }
}
