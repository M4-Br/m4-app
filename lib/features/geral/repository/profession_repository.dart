import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/geral/model/professions_response.dart';

class ProfessionRepository {
  Future<List<ProfessionsResponse>> fetchProfessions() async {
    return ApiConnection().get(
        endpoint: AppEndpoints.profession,
        fromJson: (json) {
          final list = json as List;

          return list
              .map((item) => ProfessionsResponse.fromJson(item))
              .toList();
        });
  }
}
