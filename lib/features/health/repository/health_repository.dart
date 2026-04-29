import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/health/model/health_beneficiary.dart';
import 'package:app_flutter_miban4/features/health/model/health_specialties_model.dart';
import 'package:app_flutter_miban4/features/health/model/health_plan_model.dart';

class HealthRepository {
  Future<List<HealthSpecialty>> fetchSpecialties() async {
    return await ApiConnection().get(
      endpoint: AppEndpoints.specialties,
      fromJson: (json) {
        final innerData = json['data'] as Map<String, dynamic>? ?? {};
        final list = innerData['data'] as List? ?? [];

        return list.map((item) => HealthSpecialty.fromJson(item)).toList();
      },
    );
  }

  Future<List<HealthPlanModel>> fetchPlans() async {
    return await ApiConnection().get(
      endpoint: AppEndpoints.plans,
      fromJson: (json) {
        final innerData = json['data'] as Map<String, dynamic>? ?? {};
        final list = innerData['data'] as List? ?? [];

        return list.map((item) => HealthPlanModel.fromJson(item)).toList();
      },
    );
  }

  Future<HealthBeneficiary> fetchBeneficiary(String documentId) async {
    return await ApiConnection().get(
      endpoint: '${AppEndpoints.beneficiaries}/$documentId',
      fromJson: (json) {
        final innerData = json['data'] as Map<String, dynamic>? ?? {};
        final data = innerData['data'] as Map<String, dynamic>? ?? {};
        return HealthBeneficiary.fromJson(data);
      },
    );
  }
}
