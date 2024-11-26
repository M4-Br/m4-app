import 'package:app_flutter_miban4/data/api/plans/plans.dart';
import 'package:app_flutter_miban4/data/model/plans/plans_model.dart';
import 'package:get/get.dart';

class PlansController extends GetxController {
  var isLoading = false.obs;

  Future<PlansModel> getPlan() async {
    isLoading(true);
    try {
      return await getPlans();
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
