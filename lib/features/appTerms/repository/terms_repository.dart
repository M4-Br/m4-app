import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/appTerms/model/app_terms.dart';

class TermsRepository {
  Future<AppTerms> fetchTerms() async {
    return ApiConnection().get(
        endpoint: AppEndpoints.terms,
        fromJson: (json) => AppTerms.fromJson(json));
  }
}
