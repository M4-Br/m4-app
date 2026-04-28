import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/health/model/health_specialties_model.dart';

class HealthRepository {
  Future<List<HealthSpecialty>> fetchSpecialties() async {
    return await ApiConnection().get(
      endpoint: AppEndpoints.specialties,
      fromJson: (json) {
        // A API retorna { success: true, data: { success: true, data: [...] } }
        final innerData = json['data'] as Map<String, dynamic>? ?? {};
        final list = innerData['data'] as List? ?? [];

        return list.map((item) => HealthSpecialty.fromJson(item)).toList();
      },
    );
  }
}
