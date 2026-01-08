import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/features/AI/controller/ai_action_handler.dart';
import 'package:app_flutter_miban4/features/AI/service/local_ai_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AiModal {
  AiModal._();

  static void openAiSearch() {
    final RxBool isLoading = false.obs;
    final TextEditingController textController = TextEditingController();

    void handleSubmit(String text) async {
      if (text.trim().isEmpty) return;

      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 1, milliseconds: 500));

      final response = LocalAiService.processUserIntent(text);

      Get.back();

      AiActionHandler.handle(response);
    }

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.auto_awesome,
                        color: secondaryColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      isLoading.value
                          ? 'Processando...'
                          : 'Como posso te ajudar?',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: textController,
                  autofocus: true,
                  enabled: !isLoading.value,
                  decoration: InputDecoration(
                    hintText: 'Ex: Meus pix, Pagar boleto...',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: secondaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: secondaryColor, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: isLoading.value
                        ? Transform.scale(
                            scale: 0.5,
                            child: const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(secondaryColor),
                            ),
                          )
                        : IconButton(
                            icon: const Icon(Icons.send, color: secondaryColor),
                            onPressed: () => handleSubmit(textController.text),
                          ),
                  ),
                  textInputAction: TextInputAction.go,
                  onSubmitted: (text) => handleSubmit(text),
                ),
                SizedBox(
                    height: 20 + MediaQuery.of(Get.context!).padding.bottom),
              ],
            )),
      ),
      isScrollControlled: true,
    );
  }
}
