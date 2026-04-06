import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:flutter/foundation.dart';
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

  void goToCoupons() {
    if (kDebugMode) {
      print('Ir para Cupons');
    }
  }

  void goToStores() {
    if (kDebugMode) {
      print('Ir para Lojas');
    }
  }

  void seeAllStores() {
    if (kDebugMode) {
      print('Ver todas as lojas');
    }
  }
}
