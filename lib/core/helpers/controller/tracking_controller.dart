import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';

class TrackerController extends GetxController with WidgetsBindingObserver {
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'local_button_clicks';

  static TrackerController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _sendDataToServer();
    }
  }

  // --- FUNÇÃO QUE VOCÊ VAI CHAMAR NOS BOTÕES ---
  // Exemplo de uso na Home: TrackerController.to.trackClick(12);
  void trackClick(int buttonId) {
    try {
      // 1. Lê o storage de forma segura usando o .from() para evitar erros de casting
      final storedData = _storage.read(_storageKey) ?? {};
      Map<String, dynamic> clicks = Map<String, dynamic>.from(storedData);

      // Transforma o ID em string para ser chave do Map JSON
      String key = buttonId.toString();

      // Incrementa ou inicializa com 1
      clicks[key] = ((clicks[key] as int?) ?? 0) + 1;

      // Salva no celular
      _storage.write(_storageKey, clicks);

      if (kDebugMode) {
        print('✅ CLIQUE SALVO! Botão ID: $buttonId | Total: ${clicks[key]}');
        print('📦 Storage Completo Agora: $clicks');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ ERRO AO SALVAR CLIQUE: $e');
      }
    }
  }

  // --- ENVIAR PARA O BACKEND ---
  Future<void> _sendDataToServer() async {
    Map<String, dynamic>? clicks =
        _storage.read<Map<String, dynamic>>(_storageKey);

    if (clicks == null || clicks.isEmpty) return; // Não tem nada pra enviar

    // Transforma o Map local no formato JSON que o seu backend pediu
    List<Map<String, dynamic>> eventsList = [];
    clicks.forEach((key, value) {
      eventsList.add({
        'button_id': int.parse(key),
        'clicks': value,
      });
    });

    final payload = {'events': eventsList};

    try {
      // Dispara o POST em background
      await ApiConnection().post(
        endpoint: 'API/tracking/clicks', // Crie essa rota com seu back
        body: payload,
      );

      // Se a API retornou 200 (sucesso), limpamos o celular para não mandar duplicado depois!
      _storage.remove(_storageKey);
      if (kDebugMode) {
        print('Cliques enviados e storage limpo!');
      }
    } catch (e) {
      // Se deu erro (sem internet), não faz nada.
      // O dado continua no GetStorage para tentar enviar na próxima vez!
      if (kDebugMode) {
        print('Erro ao enviar cliques. Ficarão salvos localmente.');
      }
    }
  }
}
