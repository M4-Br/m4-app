import 'package:app_flutter_miban4/data/api/account/post_financial_cap.dart';
import 'package:get/get.dart';

class FinancialDataController extends GetxController {
  var isLoading = false.obs;

  Future<void> financialData(
      String groupID,
      String income,
      String peopleFamily,
      String house,
      String transport,
      String houseCost,
      String transportCost,
      String utilitiesCost,
      String otherCosts) async {
    try {
      isLoading(true);
      await postFinancialCap(groupID, income, peopleFamily, house, transport,
              houseCost, transportCost, utilitiesCost, otherCosts)
          .then((value) => {
                if (value['id'].toString().isNotEmpty) {Get.back()}
              });
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
