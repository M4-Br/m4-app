import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/TED/model/transfer_p2p_send_request.dart';
import 'package:app_flutter_miban4/features/TED/model/transfer_voucher_response.dart';

class TransferSendP2pRepository {
  Future<TransferVoucher> send(TransferP2pSendRequest request) async {
    return ApiConnection().post(
        endpoint: AppEndpoints.tranferP2P,
        body: request.toJson(),
        fromJson: (json) => TransferVoucher.fromJson(json));
  }
}
