import 'package:app_flutter_miban4/core/config/auth/controller/user_rx.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/dates.dart';
import 'package:app_flutter_miban4/features/statements/model/statement_response.dart';
import 'package:app_flutter_miban4/features/statements/repository/statement_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:get/get.dart';

class StatementController extends GetxController {
  var isLoading = false.obs;
  final user = Get.find<UserRx>();
  final Rx<StatementResponse?> statements = Rx<StatementResponse?>(null);

  @override
  void onInit() {
    super.onInit();

    final now = DateTime.now();

    final startDate = DateTime(now.year, now.month, 1);

    final endDate = DateTime(now.year, now.month + 1, 0);

    fetchStatementsDetails(
      startDate: startDate.toYYYYMMDD(),
      endDate: endDate.toYYYYMMDD(),
    );
  }

  Future<void> fetchStatementsDetails(
      {required String startDate, required String endDate}) async {
    statements.value = null;
    isLoading.value = true;

    try {
      final currentUser = user.user.value;

      if (currentUser == null) {
        throw Exception('Usuário não autenticado. Impossível buscar extrato.');
      }

      final account = currentUser.payload.aliasAccount;

      if (account == null) {
        throw Exception('Conta do usuário não encontrada.');
      }

      final statementsData = await StatementRepository().fetchStatements(
        accountId: account.accountId,
        startDate: startDate,
        endDate: endDate,
      );

      statements.value = statementsData;
    } on UnauthorizedException catch (e) {
      ShowToaster.toasterInfo(message: e.message);
    } on ApiException catch (e) {
      ShowToaster.toasterInfo(message: e.message);
    } catch (e, s) {
      AppLogger.I().error('Fetch statements controller', e, s);
      ShowToaster.toasterInfo(
          message: 'Ocorreu um erro ao buscar os extratos. Tente novamente.');
    } finally {
      isLoading.value = false;
    }
  }
}
