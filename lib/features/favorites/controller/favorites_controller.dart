import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/favorites/model/favorites_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavoritesController extends BaseController {
  final RxList<AppFeature> favoriteFeatures = <AppFeature>[].obs;

  // Instância do GetStorage para ler os cliques locais
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    await executeSafe(() async {
      isLoading.value = true;
      favoriteFeatures.clear();

      await Future.delayed(const Duration(milliseconds: 500)); // Animação suave

      // 1. LÊ OS CLIQUES LOCAIS COM BLINDAGEM (.from)
      final storedData = _storage.read('local_button_clicks') ?? {};
      Map<String, dynamic> clicks = Map<String, dynamic>.from(storedData);

      if (kDebugMode) {
        print('🔍 Lendo Favoritos: $clicks');
      }

      // Se estiver vazio, já encerra aqui e mostra o Empty State
      if (clicks.isEmpty) {
        isLoading.value = false;
        return;
      }

      // 2. ORDENA DO MAIS CLICADO PARA O MENOS CLICADO
      var sortedKeys = clicks.keys.toList(growable: false)
        ..sort((k1, k2) => (clicks[k2] as int).compareTo(clicks[k1] as int));

      // 3. PEGA OS 10 MAIS CLICADOS E CONVERTE PARA INTEIRO
      List<int> top10Ids =
          sortedKeys.take(10).map((k) => int.parse(k)).toList();

      // 4. TRADUZ OS NÚMEROS EM BOTÕES USANDO O DICIONÁRIO
      final mappedFeatures = AppDictionary.getFeaturesByIds(top10Ids);

      favoriteFeatures.assignAll(mappedFeatures);
    }, message: 'Erro ao carregar seus serviços favoritos.');

    isLoading.value = false;
  }
}
