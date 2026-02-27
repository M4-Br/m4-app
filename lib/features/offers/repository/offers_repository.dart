import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/offers/model/offers_response.dart';

class OffersRepository {
  Future<OfferResponse> fetchOffers() async {
    return ApiConnection().get(
        endpoint: AppEndpoints.offers,
        fromJson: (json) => OfferResponse.fromJson(json));
  }
}
