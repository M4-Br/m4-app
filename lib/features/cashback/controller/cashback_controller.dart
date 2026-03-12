import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:get/get.dart';

class MockStore {
  final String name;
  final String category;

  MockStore({required this.name, required this.category});
}

class CashbackController extends BaseController {
  final RxDouble balance = 0.0.obs;
  final RxInt activeCoupons = 0.obs;
  final RxInt partnerStoresCount = 5.obs;

  final List<MockStore> mockStores = [
    MockStore(name: 'Padaria Pão Quente', category: 'Restaurante'),
    MockStore(name: 'Brechó Fashion', category: 'Vestuario'),
    MockStore(name: 'Farmácia Saúde Total', category: 'Farmacia'),
  ];

  @override
  void onInit() {
    super.onInit();
    // No futuro, você chama a API aqui via executeSafe()
  }

  void goToCoupons() {
    print('Ir para Cupons');
  }

  void goToStores() {
    print('Ir para Lojas');
  }

  void seeAllStores() {
    print('Ver todas as lojas');
  }
}
