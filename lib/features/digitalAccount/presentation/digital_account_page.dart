import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/features/balance/presentation/card_widget.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/digitalAccount/controller/digital_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DigitalAccountPage extends GetView<DigitalAccountController> {
  const DigitalAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: const CustomAppBar(
        title: 'CARTEIRA DIGITAL',
        showBackButton: false,
      ),
      body: CustomPageBody(
        enableIntrinsicHeight: false,
        children: [
          const SizedBox(height: 16),
          const CardWidget(),
          const SizedBox(height: 24),
          _buildUnifiedServicesList(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildUnifiedServicesList() {
    const Color iconColor = primaryColor;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildListItem(
            icon: Icons.receipt_long_outlined,
            title: 'Extrato da Conta',
            subtitle: 'Histórico de transações',
            iconColor: iconColor,
            onTap: () => controller.onOptionTap('statement'),
            isAsset: false,
          ),
          const Divider(height: 1, indent: 56, endIndent: 16),
          _buildListItem(
            assetPath: 'assets/icons/ic_home_pix.png',
            title: 'Área Pix',
            subtitle: 'Envie e receba em segundos',
            iconColor: iconColor,
            onTap: () => controller.onOptionTap('pix'),
          ),
          const Divider(height: 1, indent: 56, endIndent: 16),
          _buildListItem(
            assetPath: 'assets/icons/ic_home_transfer.png',
            title: 'Transferências',
            subtitle: 'Tranferência entre contas parceiras',
            iconColor: iconColor,
            onTap: () => controller.onOptionTap('transfer'),
          ),
          const Divider(height: 1, indent: 56, endIndent: 16),
          _buildListItem(
            assetPath: 'assets/icons/ic_home_payment_invoice.png',
            title: 'Pagamento de Boleto',
            subtitle: 'Contas de água, luz e mais',
            iconColor: iconColor,
            onTap: () => controller.onOptionTap('barcode'),
          ),
          // const Divider(height: 1, indent: 56, endIndent: 16),
          // _buildListItem(
          //   icon: Icons.trending_up,
          //   title: 'Investimentos',
          //   subtitle: 'Renda fixa e variável',
          //   iconColor: iconColor,
          //   onTap: _showComingSoonSnackbar,
          //   isAsset: false,
          // ),
          // const Divider(height: 1, indent: 56, endIndent: 16),
          // _buildListItem(
          //   icon: Icons.domain,
          //   title: 'Seguros',
          //   subtitle: 'Proteção e garantias',
          //   iconColor: iconColor,
          //   onTap: _showComingSoonSnackbar,
          //   isAsset: false,
          // ),
        ],
      ),
    );
  }

  // --- COMPONENTE BASE ---
  Widget _buildListItem({
    IconData? icon,
    String? assetPath,
    required String title,
    String? subtitle,
    required Color iconColor,
    required VoidCallback onTap,
    bool isAsset = true,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: isAsset && assetPath != null
          ? Image.asset(assetPath, width: 28, color: iconColor)
          : Icon(icon, size: 28, color: iconColor),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      subtitle: subtitle != null
          ? Text(subtitle,
              style: const TextStyle(fontSize: 13, color: Colors.grey))
          : null,
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
