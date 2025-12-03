import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/pix/transfer/model/pix_transfer_request.dart';
import 'package:app_flutter_miban4/features/pix/transfer/model/pix_transfer_response.dart';

class PixTransferRepository {
  Future<PixTransferResponse> doTransfer(
      {required PixTransferRequest request}) async {
    return ApiConnection().post(
        endpoint: AppEndpoints.pixTransfer,
        body: request.toJson(),
        fromJson: (json) => PixTransferResponse.fromJson(json));
  }
}
