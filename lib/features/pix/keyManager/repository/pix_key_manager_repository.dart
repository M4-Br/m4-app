import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/pix/keyManager/model/pix_key_delete_response.dart';
import 'package:app_flutter_miban4/features/pix/keyManager/model/pix_key_response.dart';

class PixKeyManagerRepository {
  Future<PixKeyResponse> fetchKeys() async {
    return ApiConnection().get(
        endpoint: AppEndpoints.pixKeyManager,
        fromJson: (json) => PixKeyResponse.fromJson(json));
  }

  Future<PixKeyDeleteResponse> deleteKey(String key) async {
    return ApiConnection().delete(
        endpoint: AppEndpoints.pixKeyManager,
        body: {'key': key},
        fromJson: (json) => PixKeyDeleteResponse.fromJson(json));
  }
}
