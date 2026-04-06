import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/ai/model/ai_manager_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiManagerController extends BaseController {
  final String _apiKey =
      const String.fromEnvironment('GEMINI_KEY', defaultValue: '') != ''
          ? const String.fromEnvironment('GEMINI_KEY')
          : dotenv.env['GEMINI_KEY'] ?? '';

  late final GenerativeModel _model;
  late final ChatSession _chatSession;

  final textController = TextEditingController();
  final scrollController = ScrollController();
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initAI();
  }

  void _initAI() {
    if (kDebugMode) {
      print('A CHAVE QUE ESTÁ INDO PRO GOOGLE É: "$_apiKey"');
    }

    final systemInstruction = Content.system('''
      Você é o Max, o Gerente de Contas Virtual oficial do M4, um banco digital e ecossistema de negócios para empreendedores.
      Seu tom de voz é profissional, extremamente útil, motivador e ligeiramente informal, como um bom parceiro de negócios moderno.
      Você pode usar emojis para deixar a conversa amigável, mas sem exageros.
      
      Seu objetivo é ajudar o usuário com:
      1. Funcionalidades do app M4 (Contabilidade Gerencial, Marketplace de Parceiros, Controle de Estoque, Clientes, Membresia/Cashback, Transferencia, Pix, Pagamento de Boletos).
      2. Dúvidas burocráticas sobre negócios (MEI, emissão de DAS, planejamento financeiro, dicas de vendas).
      
      Regra de Ouro: Se o usuário perguntar qualquer coisa que NÃO seja sobre o app M4, negócios, finanças ou empreendedorismo (ex: receitas, política, programação avançada, etc.), responda educadamente que sua especialidade é apenas ajudar o negócio dele a crescer com o M4.
    ''');

    _model = GenerativeModel(
      model: 'gemini-2.5-flash-lite',
      apiKey: _apiKey,
      systemInstruction: systemInstruction,
    );

    _chatSession = _model.startChat();

    final userName =
        userRx.user.value?.payload.username.split(' ').first ?? 'parceiro';
    messages.add(ChatMessage(
        text:
            'Olá, $userName! 👋 Eu sou o Max, seu Gerente de Contas Virtual aqui no M4.\n\nComo posso ajudar a impulsionar o seu negócio hoje?',
        isMax: true));
  }

  Future<void> sendMessage() async {
    final messageText = textController.text.trim();
    if (messageText.isEmpty) return;

    messages.add(ChatMessage(text: messageText, isMax: false));
    textController.clear();
    _scrollToBottom();

    isLoading.value = true;

    try {
      final response =
          await _chatSession.sendMessage(Content.text(messageText));

      if (response.text != null) {
        messages.add(ChatMessage(text: response.text!, isMax: true));
      }
    } catch (e) {
      messages.add(ChatMessage(
          text:
              'Puxa, minha conexão falhou aqui na agência virtual. Tente mandar de novo!',
          isMax: true));
    } finally {
      isLoading.value = false;
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
