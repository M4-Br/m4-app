import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/store/model/store_response.dart';
import 'package:app_flutter_miban4/features/store/repository/store_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:get/get.dart';

class StoreController extends BaseController {
  final RxList<StoreResponse> storeList = <StoreResponse>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMerchants();
  }

  Future<void> getMerchants() async {
    await executeSafe(() async {
      final result = await StoreRepository().fetchStore();
      storeList.assignAll(result);
    });
  }

  void onStoreTap(StoreResponse store) {
    ShowToaster.toasterInfo(message: 'Abrindo ${store.merchantName}...');
  }
}
