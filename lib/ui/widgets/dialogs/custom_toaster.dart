import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowToaster {
  const ShowToaster._();

  static void toasterInfo({required String message, bool isError = false}) {
    // 1. Tenta pegar o contexto atual globalmente
    final context = Get.context;

    // Se não tiver contexto (raro, mas possível), imprime no console para debug
    if (context == null) {
      debugPrint('ShowToaster Error: Contexto nulo. Mensagem: $message');
      return;
    }

    // 2. Garante que o teclado feche
    FocusManager.instance.primaryFocus?.unfocus();

    // 3. Usa o método NATIVO do Flutter (mais robusto que o Get.snackbar)
    ScaffoldMessenger.of(context).clearSnackBars(); // Limpa anteriores

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.info_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        // Cores baseadas no erro
        backgroundColor: isError ? Colors.redAccent : const Color(0xFF333333),

        // Comportamento
        behavior: SnackBarBehavior.floating, // Flutua sobre o conteúdo
        margin: const EdgeInsets.all(16), // Margem ao redor
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 4),

        // IMPORTANTE: Isso garante que apareça mesmo com teclado
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}
