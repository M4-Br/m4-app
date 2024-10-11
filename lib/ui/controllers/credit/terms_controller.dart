import 'package:app_flutter_miban4/data/api/credit/getTerms.dart';
import 'package:get/get.dart';

class CreditTermsController extends GetxController {
  var isLoading = false.obs;

  Future<void> getTerms() async {
    isLoading(true);

    try {
      await getCreditTerms();
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
