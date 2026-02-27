import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/offers/model/offers_response.dart';
import 'package:app_flutter_miban4/features/offers/repository/offers_repository.dart';
import 'package:get/get.dart';

class OffersController extends BaseController {
  final OffersRepository _repository = OffersRepository();

  final List<OfferModel> offersList = <OfferModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getOffers();
  }

  Future<void> getOffers() async {
    isLoading.value = true;

    await executeSafe(() async {
      final response = await _repository.fetchOffers();
      if (response.success == true && response.data != null) {
        offersList.assignAll(response.data!);
      } else {
        offersList.clear();
      }
    });

    isLoading.value = false;
  }
}
