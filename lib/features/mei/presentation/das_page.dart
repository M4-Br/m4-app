import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/mei/controller/das_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DasPage extends GetView<DasController> {
  const DasPage({super.key});

  final Color _greenDark = const Color(0xFF065F46);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBar(title: 'PAGAMENTO DAS'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: AppLoading());
        }

        final response = controller.dasData.value;

        if (response == null || !response.success || response.data == null) {
          return const Center(
              child: Text('Erro ao se comunicar com a Receita Federal.'));
        }

        final data = response.data!;

        if (data.dados.isEmpty) {
          String errorMessage = 'Nenhum boleto encontrado para este CNPJ.';

          if (data.mensagens.isNotEmpty) {
            errorMessage = data.mensagens.first.texto;
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.info_outline,
                      size: 48, color: Colors.orange),
                  const SizedBox(height: 16),
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
          );
        }

        final dadosEmpresa = data.dados.first;
        if (dadosEmpresa.detalhamento.isEmpty) {
          return const Center(
              child: Text('Nenhum detalhamento financeiro disponível.'));
        }

        final boleto = dadosEmpresa.detalhamento.first;

        return CustomPageBody(
          padding: const EdgeInsets.all(20),
          enableIntrinsicHeight: false,
          children: [
            // --- DADOS DA EMPRESA ---
            _buildInfoCard('Dados da Empresa', [
              _infoRow('CNPJ', dadosEmpresa.cnpjCompleto),
              _infoRow('Razão Social', dadosEmpresa.razaoSocial),
              _infoRow('Apurado',
                  '${boleto.periodoApuracao.substring(4, 6)}/${boleto.periodoApuracao.substring(0, 4)}'),
            ]),
            const SizedBox(height: 20),

            // --- VALOR E VENCIMENTO ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _greenDark,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: _greenDark.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                children: [
                  const Text('Valor a Pagar',
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 8),
                  Text(
                      'R\$ ${boleto.valores.total.toStringAsFixed(2).replaceAll('.', ',')}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                        'Vencimento: ${_formatarData(boleto.dataVencimento)}',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // --- DETALHAMENTO DE VALORES ---
            _buildInfoCard('Composição do Valor', [
              _infoRow('Principal',
                  'R\$ ${boleto.valores.principal.toStringAsFixed(2)}'),
              _infoRow(
                  'Multa', 'R\$ ${boleto.valores.multa.toStringAsFixed(2)}'),
              _infoRow(
                  'Juros', 'R\$ ${boleto.valores.juros.toStringAsFixed(2)}'),
              const Divider(),
              _infoRow(
                  'Total', 'R\$ ${boleto.valores.total.toStringAsFixed(2)}',
                  isBold: true),
            ]),
            const SizedBox(height: 20),

            // --- CÓDIGO DE BARRAS ---
            _buildInfoCard('Código de Barras', [
              Text(boleto.linhaDigitavel,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5)),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: boleto.linhaDigitavel));
                    ShowToaster.toasterInfo(
                        message: 'Código copiado com sucesso!');
                  },
                  icon: Icon(Icons.copy, color: _greenDark),
                  label: Text('COPIAR CÓDIGO',
                      style: TextStyle(
                          color: _greenDark, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: _greenDark),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ]),

            const SizedBox(height: 32),

            // --- BOTÃO DE PDF ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => ShowToaster.toasterInfo(
                    message: 'Download do PDF em breve!'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _greenDark,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('BAIXAR BOLETO (PDF)',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        );
      }),
    );
  }

  // Widget auxiliar para as linhas
  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 16)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // Garante que se o texto tiver 2 linhas, o "Label" fique alinhado no topo
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(width: 16), // Dá um respiro entre o título e o valor

          // O Expanded permite que o texto ocupe o resto do espaço e quebre a linha
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right, // Mantém o texto alinhado à direita
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
                  color: isBold ? Colors.black : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  // Transforma 20230320 em 20/03/2023
  String _formatarData(String dataInvertida) {
    if (dataInvertida.length != 8) return dataInvertida;
    final ano = dataInvertida.substring(0, 4);
    final mes = dataInvertida.substring(4, 6);
    final dia = dataInvertida.substring(6, 8);
    return '$dia/$mes/$ano';
  }
}
