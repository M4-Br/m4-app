import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/partners/model/partners_model.dart';
import 'package:get/get.dart';

class PartnerReceiptController extends BaseController {
  late PartnerItem item;
  late String operationId;
  late String transactionDate;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      item = args['item'];
      operationId = args['operationId'] ?? '#Operação Indisponível';
    }

    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year;
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');

    transactionDate = '$day/$month/$year | $hour:$minute';
  }

  void backToHome() {
    Get.until((route) => Get.currentRoute == AppRoutes.homeView);
  }

  void shareReceipt() {
    AppLogger.I().info('Compartilhando comprovante da operação: $operationId');
  }
}
