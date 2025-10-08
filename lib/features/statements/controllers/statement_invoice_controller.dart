import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/statements/model/statement_invoice_response.dart';
import 'package:app_flutter_miban4/features/statements/repository/statement_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:get/get.dart';

class StatementInvoiceController extends GetxController {
  var isLoading = false.obs;
  final Rx<StatementInvoice?> invoice = Rx<StatementInvoice?>(null);

  @override
  void onInit() {
    super.onInit();
    final String? statementId = Get.parameters['id'];

    if (statementId != null) {
      fetchInvoiceDetails(statementId);
    } else {
      isLoading.value = false;
    }
  }

  Future<void> fetchInvoiceDetails(String statementId) async {
    isLoading(true);

    try {
      final result =
          await StatementRepository().fetchInvoice(statementId: statementId);
      invoice.value = result;
    } on UnauthorizedException catch (e) {
      ShowToaster.toasterInfo(message: e.message);
      rethrow;
    } on ApiException catch (e) {
      ShowToaster.toasterInfo(message: e.message);
      rethrow;
    } catch (e, s) {
      AppLogger.I().error('Fetch statements invoice controller', e, s);
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
