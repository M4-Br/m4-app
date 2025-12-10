import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/TED/model/transfer_user_response.dart';

class TransferNewContactRepository {
  Future<TransferUserResponse> fetchUser(String document) async {
    return ApiConnection().get(
        endpoint: '${AppEndpoints.transferFindContact}/$document',
        fromJson: (json) => TransferUserResponse.fromJson(json));
  }
}
