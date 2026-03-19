import 'package:app_flutter_miban4/features/ai/controller/ai_manager_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AiManagerPage extends GetView<AiManagerController> {
  const AiManagerPage({super.key});

  final Color _greenDark = const Color(0xFF065F46);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: _greenDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              radius: 18,
              child: const Icon(Icons.support_agent,
                  color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Max (IA)',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Text('Gerente de Contas Virtual',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 1. ÁREA DAS MENSAGENS
          Expanded(
            child: Obx(() => ListView.builder(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.messages.length +
                      (controller.isLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    // Se for o último item e estiver carregando, mostra o indicador de digitação
                    if (index == controller.messages.length &&
                        controller.isLoading.value) {
                      return _buildTypingIndicator();
                    }

                    final msg = controller.messages[index];
                    return _buildMessageBubble(msg.text, msg.isMax);
                  },
                )),
          ),

          // 2. CAMPO DE DIGITAÇÃO
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4))
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: controller.textController,
                        maxLines: 4,
                        minLines: 1,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => controller.sendMessage(),
                        decoration: InputDecoration(
                          hintText: 'Pergunte ao Max...',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Obx(() => Material(
                        color: controller.isLoading.value
                            ? Colors.grey.shade400
                            : _greenDark,
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: controller.isLoading.value
                              ? null
                              : controller.sendMessage,
                          customBorder: const CircleBorder(),
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Icon(Icons.send_rounded,
                                color: Colors.white, size: 20),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- BALÃO DE MENSAGEM ---
  Widget _buildMessageBubble(String text, bool isMax) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment:
            isMax ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isMax) ...[
            CircleAvatar(
              backgroundColor: _greenDark.withValues(alpha: 0.1),
              radius: 16,
              child: Icon(Icons.support_agent, color: _greenDark, size: 18),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMax ? Colors.white : _greenDark,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isMax ? 0 : 16),
                  bottomRight: Radius.circular(isMax ? 16 : 0),
                ),
                border: isMax ? Border.all(color: Colors.grey.shade200) : null,
                boxShadow: [
                  if (isMax)
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 4,
                        offset: const Offset(0, 2))
                ],
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isMax ? Colors.black87 : Colors.white,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (!isMax)
            const SizedBox(
                width: 24), // Espaço pro balão do usuário não colar na borda
        ],
      ),
    );
  }

  // --- INDICADOR "MAX ESTÁ DIGITANDO..." ---
  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor: _greenDark.withValues(alpha: 0.1),
            radius: 16,
            child: Icon(Icons.support_agent, color: _greenDark, size: 18),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: _greenDark),
                ),
                const SizedBox(width: 12),
                Text('Max está digitando...',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                        fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
