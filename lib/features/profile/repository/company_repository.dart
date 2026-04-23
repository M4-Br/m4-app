import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/profile/model/company_register_model.dart';

class CompanyRepository {
  Future<dynamic> registerCompany(CompanyRegisterModel company) async {
    return await ApiConnection().post(
      endpoint: AppEndpoints.company,
      body: company.toJson(),
      fromJson: (json) => json,
    );
  }

  Future<CompanyRegisterModel?> fetchCompany(int id) async {
    return await ApiConnection().get(
      endpoint: '${AppEndpoints.company}/$id',
      fromJson: (json) {
        if (json != null && json['data'] != null) {
          return CompanyRegisterModel.fromJson(json['data']);
        }
        return null;
      },
    );
  }
}
