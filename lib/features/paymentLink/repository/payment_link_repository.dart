import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/paymentLink/model/payment_link_response.dart';

class PaymentLinkRepository {
  Future<PaymentLinkResponse> createLink({required String amount}) async {
    return ApiConnection().post(
      endpoint: AppEndpoints.paymentLink,
      body: {'amount': amount},
      fromJson: (json) => PaymentLinkResponse.fromJson(json),
    );
  }
}
