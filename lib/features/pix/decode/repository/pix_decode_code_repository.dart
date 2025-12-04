import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/pix/copyPaste/model/pix_copy_paste_response.dart';

class PixDecodeCodeRepository {
  Future<PixDecodeResponse> decode(String code) async {
    return ApiConnection().post(
        endpoint: AppEndpoints.pixCodeDecode,
        body: {'content': code},
        fromJson: (json) => PixDecodeResponse.fromJson(json));
  }
}
