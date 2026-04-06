import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/accounting/model/accounting_summary_model.dart';

class AccountingRepository {
  Future<AccountingSummaryModel> fetchAccounting({required int year}) async {
    return ApiConnection().get(
      endpoint: '${AppEndpoints.accountingData}?year=$year',
      fromJson: (json) {
        final dataList = json['data'] as List?;

        if (dataList != null && dataList.isNotEmpty) {
          return AccountingSummaryModel.fromJson(
              dataList.first as Map<String, dynamic>);
        } else {
          throw Exception('Nenhum dado contábil encontrado.');
        }
      },
    );
  }
}
