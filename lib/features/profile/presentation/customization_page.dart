import 'package:app_flutter_miban4/core/helpers/utils/app_enums.dart';
import 'package:app_flutter_miban4/features/profile/controller/customization_controller.dart';
import 'package:app_flutter_miban4/features/profile/service/customization_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomizationPage extends GetView<CustomizationController> {
  const CustomizationPage({super.key});

  final Color _greenDark = const Color(0xFF065F46);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: _greenDark,
        elevation: 0,
        title: const Text('Personalização',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estilo dos Ícones da Home',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 8),
            const Text(
              'Escolha como você deseja visualizar os atalhos na tela inicial.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Obx(() {
              final currentStyle = CustomizationService.to.homeIconStyle.value;
              return Column(
                children: [
                  _buildStyleOption(
                    title: 'Padrão (Ícone e Texto)',
                    style: HomeIconStyle.standard,
                    currentStyle: currentStyle,
                    preview: _buildStandardPreview(),
                  ),
                  const SizedBox(height: 16),
                  _buildStyleOption(
                    title: 'Apenas Ícones',
                    style: HomeIconStyle.iconOnly,
                    currentStyle: currentStyle,
                    preview: _buildIconOnlyPreview(),
                  ),
                  const SizedBox(height: 16),
                  _buildStyleOption(
                    title: 'Apenas Nomes',
                    style: HomeIconStyle.textOnly,
                    currentStyle: currentStyle,
                    preview: _buildTextOnlyPreview(),
                  ),
                  const SizedBox(height: 16),
                  _buildStyleOption(
                    title: 'Lista Vertical',
                    style: HomeIconStyle.verticalList,
                    currentStyle: currentStyle,
                    preview: _buildVerticalListPreview(),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStyleOption({
    required String title,
    required HomeIconStyle style,
    required HomeIconStyle currentStyle,
    required Widget preview,
  }) {
    final isSelected = style == currentStyle;

    return GestureDetector(
      onTap: () => controller.setHomeIconStyle(style),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _greenDark : Colors.grey.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: _greenDark.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: isSelected ? _greenDark : Colors.grey,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? _greenDark : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: preview,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandardPreview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildPreviewItem(Icons.pix, 'Pix'),
        _buildPreviewItem(Icons.qr_code_scanner, 'Pagar'),
        _buildPreviewItem(Icons.account_balance_wallet, 'Extrato'),
      ],
    );
  }

  Widget _buildIconOnlyPreview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildPreviewIcon(Icons.pix),
        _buildPreviewIcon(Icons.qr_code_scanner),
        _buildPreviewIcon(Icons.account_balance_wallet),
      ],
    );
  }

  Widget _buildTextOnlyPreview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildPreviewText('Pix'),
        _buildPreviewText('Pagar'),
        _buildPreviewText('Extrato'),
      ],
    );
  }

  Widget _buildVerticalListPreview() {
    return Column(
      children: [
        _buildPreviewRow(Icons.pix, 'Pix'),
        const Divider(height: 8),
        _buildPreviewRow(Icons.qr_code_scanner, 'Pagar'),
        const Divider(height: 8),
        _buildPreviewRow(Icons.account_balance_wallet, 'Extrato'),
      ],
    );
  }

  Widget _buildPreviewItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: _greenDark, size: 24),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.black87)),
      ],
    );
  }

  Widget _buildPreviewIcon(IconData icon) {
    return Icon(icon, color: _greenDark, size: 28);
  }

  Widget _buildPreviewText(String label) {
    return Text(label,
        style: TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: _greenDark));
  }

  Widget _buildPreviewRow(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: _greenDark, size: 20),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black87)),
        const Spacer(),
        const Icon(Icons.chevron_right, size: 16, color: Colors.black26),
      ],
    );
  }
}
