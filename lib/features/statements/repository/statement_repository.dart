import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/statements/model/statement_invoice_response.dart';
import 'package:app_flutter_miban4/features/statements/model/statement_response.dart';

class StatementRepository {
  Future<StatementResponse> fetchStatements({
    required String accountId,
    required String startDate,
    required String endDate,
  }) async {
    return await ApiConnection().get(
        endpoint: AppEndpoints.statement,
        fromJson: (json) => StatementResponse.fromJson(json),
        queryParameters: {
          'accountId': accountId,
          'startDate': startDate,
          'endDate': endDate
        });
  }

  Future<StatementInvoice> fetchInvoice({required String statementId}) async {
    return await ApiConnection().get(
        endpoint: '${AppEndpoints.statementInvoice}$statementId',
        fromJson: (json) => StatementInvoice.fromJson(
              json,
            ));
  }
}
