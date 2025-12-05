import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/pix/statement/model/pix_statement_response.dart';
import 'package:app_flutter_miban4/features/statements/model/statement_invoice_response.dart';

class PixStatementRepository {
  Future<PixStatementResponse> fetchStatement(
      String startDate, String endDate) async {
    return await ApiConnection().get(
        endpoint: AppEndpoints.pixTransfer,
        queryParameters: {'startDate': startDate, 'endDate': endDate},
        fromJson: (json) => PixStatementResponse.fromJson(json));
  }

  Future<StatementInvoice> fetchInvoice({required String statementId}) async {
    return await ApiConnection().get(
        endpoint: '${AppEndpoints.statementInvoice}$statementId',
        fromJson: (json) => StatementInvoice.fromJson(
              json,
            ));
  }
}
