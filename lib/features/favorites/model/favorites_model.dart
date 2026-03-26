import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';

// 1. O molde do botão
class AppFeature {
  final int id;
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  AppFeature({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

// 2. O catálogo oficial do M4
class AppDictionary {
  static final List<AppFeature> allFeatures = [
    // --- HOME (1 a 9) ---
    AppFeature(
      id: 1,
      title: 'Membresia',
      icon: Icons.account_balance_wallet_outlined,
      color: const Color(0xFF1ABC9C),
      onTap: () => Get.toNamed(AppRoutes.cashback),
    ),
    AppFeature(
      id: 2, title: 'Marketplace', icon: Icons.storefront_outlined,
      color: const Color(0xFFE67E22),
      onTap: () =>
          Get.toNamed(AppRoutes.marketplace), // Ou seu HomeViewController index
    ),
    AppFeature(
      id: 3,
      title: 'Crédito',
      icon: Icons.bar_chart,
      color: const Color(0xFF3498DB),
      onTap: () => Get.toNamed(AppRoutes.score),
    ),
    AppFeature(
      id: 4,
      title: 'Notícias',
      icon: Icons.newspaper_outlined,
      color: const Color(0xFFE74C3C),
      onTap: () => Get.toNamed(AppRoutes.newsletter),
    ),
    AppFeature(
      id: 5,
      title: 'IA',
      icon: Icons.auto_awesome_outlined,
      color: const Color(0xFF9B59B6),
      onTap: () => Get.toNamed(AppRoutes.aiPage),
    ),
    AppFeature(
      id: 6,
      title: 'Gestão Fácil',
      icon: Icons.pie_chart_outline,
      color: const Color(0xFF8E44AD),
      onTap: () => Get.toNamed(AppRoutes.accountingHome),
    ),
    AppFeature(
      id: 7,
      title: 'Nossos Parceiros',
      icon: Icons.handshake_outlined,
      color: const Color(0xFF1E00AD),
      onTap: () => Get.toNamed(AppRoutes.partners),
    ),
    AppFeature(
      id: 8,
      title: 'Meus Clientes',
      icon: Icons.people_outline,
      color: const Color(0xFF2C3E50),
      onTap: () => Get.toNamed(AppRoutes.clients),
    ),
    AppFeature(
      id: 9,
      title: 'Fale Conosco',
      icon: Icons.headset_mic_outlined,
      color: const Color(0xFF00B8D4),
      onTap: () => Get.toNamed(AppRoutes.contacts),
    ),

    // --- CONTA DIGITAL (10 a 14) ---
    AppFeature(
      id: 10,
      title: 'Extrato de Conta',
      icon: Icons.receipt_long_outlined,
      color: const Color(0xFF2980B9),
      onTap: () => Get.toNamed(AppRoutes.statement),
    ),
    AppFeature(
      id: 11,
      title: 'Transferências',
      icon: Icons.swap_horiz,
      color: const Color(0xFF16A085),
      onTap: () => Get.toNamed(AppRoutes.transfer),
    ),
    AppFeature(
      id: 12,
      title: 'Pagar Boletos',
      icon: Icons.qr_code_scanner,
      color: const Color(0xFFD35400),
      onTap: () => Get.toNamed(AppRoutes.barcode),
    ),
    AppFeature(
      id: 13,
      title: 'Investimentos',
      icon: Icons.trending_up,
      color: const Color(0xFF27AE60),
      onTap: () => ShowToaster.toasterInfo(message: 'Investimentos em breve.'),
    ),
    AppFeature(
      id: 14,
      title: 'Seguros',
      icon: Icons.health_and_safety_outlined,
      color: const Color(0xFFC0392B),
      onTap: () => ShowToaster.toasterInfo(message: 'Seguros em breve.'),
    ),

    // --- ÁREA PIX (15 a 23) ---
    AppFeature(
      id: 15,
      title: 'Área Pix',
      icon: Icons.pix,
      color: const Color(0xFF32BCAD),
      onTap: () => Get.toNamed(AppRoutes.pixHome),
    ),
    AppFeature(
      id: 16,
      title: 'Extrato Pix',
      icon: Icons.list_alt,
      color: const Color(0xFF32BCAD),
      onTap: () => Get.toNamed(AppRoutes.pixStatement),
    ),
    AppFeature(
      id: 17,
      title: 'Gerenciar Chaves',
      icon: Icons.vpn_key_outlined,
      color: const Color(0xFF32BCAD),
      onTap: () => Get.toNamed(AppRoutes.pixKeyManager),
    ),
    AppFeature(
      id: 18,
      title: 'Limites Pix',
      icon: Icons.speed,
      color: const Color(0xFF32BCAD),
      onTap: () => Get.toNamed(AppRoutes.pixLimits),
    ),
    AppFeature(
      id: 19,
      title: 'Receber Pix',
      icon: Icons.call_received,
      color: const Color(0xFF32BCAD),
      onTap: () => Get.toNamed(AppRoutes.pixReceive),
    ),
    AppFeature(
      id: 20,
      title: 'Pix com Chave',
      icon: Icons.send,
      color: const Color(0xFF32BCAD),
      onTap: () => Get.toNamed(AppRoutes.pixWithKey),
    ),
    AppFeature(
      id: 21,
      title: 'Pix Agendado',
      icon: Icons.schedule,
      color: const Color(0xFF32BCAD),
      onTap: () => Get.toNamed(AppRoutes.pixScheduled),
    ),
    AppFeature(
      id: 22,
      title: 'Ler QR Code',
      icon: Icons.qr_code,
      color: const Color(0xFF32BCAD),
      onTap: () => Get.toNamed(AppRoutes.pixQrCodeReader),
    ),
    AppFeature(
      id: 23,
      title: 'Pix Copia e Cola',
      icon: Icons.content_copy,
      color: const Color(0xFF32BCAD),
      onTap: () => Get.toNamed(AppRoutes.pixCopyPaste),
    ),
  ];

  // Função mágica (AGORA ORDENA CORRETAMENTE)
  static List<AppFeature> getFeaturesByIds(List<int> idsDoBackend) {
    // Mapeia pela ordem exata do array do backend (mais clicados primeiro)
    return idsDoBackend
        .map(
            (id) => allFeatures.firstWhereOrNull((feature) => feature.id == id))
        .whereType<AppFeature>() // Remove nulls caso um ID não exista mais
        .toList();
  }
}
