import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/model/barcode_payment_request.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/model/barcode_payment_response.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/model/barcode_response.dart';

class BarcodeRepository {
  Future<BarcodeResponse> decodeBarcode(String barcode) async {
    return ApiConnection().get(
        endpoint: '${AppEndpoints.barcode}/barcode',
        fromJson: (json) => BarcodeResponse.fromJson(json));
  }

  Future<BarcodePaymentResponse> doPayment(
      BarcodePaymentRequest request) async {
    return ApiConnection().post(
        endpoint: AppEndpoints.barcodePayment,
        body: request,
        fromJson: (json) => BarcodePaymentResponse.fromJson(json));
  }
}
