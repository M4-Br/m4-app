import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowToaster {
  const ShowToaster._();

  static void toasterInfo({required String message, bool isError = false}) {
    final context = Get.context;
    if (context == null) {
      debugPrint('ShowToaster Error: Contexto nulo. Mensagem: $message');
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    ScaffoldMessenger.of(context).clearSnackBars();

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
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 4),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}
