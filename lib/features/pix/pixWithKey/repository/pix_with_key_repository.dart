import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/pix/pixWithKey/model/pix_validate_key_response.dart';

class PixWithKeyRepository {
  Future<PixValidateKeyResponse> validateKey(String key) async {
    return ApiConnection().get(
        endpoint: '${AppEndpoints.pixValidateKey}/$key',
        fromJson: (json) => PixValidateKeyResponse.fromJson(json));
  }
}
