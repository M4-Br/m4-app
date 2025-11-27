import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/profile/repository/plans_repository.dart';
import 'package:app_flutter_miban4/features/profile/model/plans_response.dart';
import 'package:get/get.dart';

class PlansController extends BaseController {
  PlansController();

  final plans = Rxn<UserPlansResponse>();

  @override
  void onInit() {
    super.onInit();
    fetchPlansDetails();
  }

  Future<void> fetchPlansDetails() async {
    await executeSafe(() async {
      plans.value = null;

      final userPlans = await PlansRepository().fetchPlans(
          accountId: userRx.user.value!.payload.aliasAccount!.accountId);

      plans.value = userPlans;
    }, message: 'Erro ao carregar planos do usuário');
  }
}
