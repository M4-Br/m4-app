import 'package:app_flutter_miban4/data/api/store/store_request.dart';
import 'package:app_flutter_miban4/data/model/store/store_model.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  var isLoading = false.obs;
  var merchantList = <Merchant>[].obs;

  Future<void> getMerchants() async {
    isLoading(true);

    try {
      final merchants = await merchantRequest();
      merchantList.value = merchants;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
