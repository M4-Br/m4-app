import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/pix/receive/model/pix_create_qr_code_request.dart';
import 'package:app_flutter_miban4/features/pix/receive/model/pix_create_qr_code_response.dart';

class PixReceiveRepository {
  Future<PixCreateQrCodeResponse> createCode(
      {required PixCreateQrCodeRequest request}) async {
    return await ApiConnection().post(
        endpoint: AppEndpoints.pixReceive,
        body: request.toJson(),
        fromJson: (json) => PixCreateQrCodeResponse.fromJson(json));
  }
}
