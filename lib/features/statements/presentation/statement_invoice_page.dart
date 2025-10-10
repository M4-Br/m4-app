import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/statements/controllers/statement_invoice_controller.dart';
import 'package:app_flutter_miban4/features/statements/model/statement_invoice_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatementInvoiceScreen extends GetView<StatementInvoiceController> {
  const StatementInvoiceScreen({super.key});

  static final GlobalKey _invoiceKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText.titleLarge(
          context,
          'Comprovante', // Título mais específico
          color: Colors.white,
        ),
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: AppLoading());
        }

        final invoice = controller.invoice.value;

        if (invoice == null) {
          return Center(
            child: AppText.bodyLarge(
              context,
              'Não foi possível carregar o comprovante.',
              color: Colors.grey.shade600,
            ),
          );
        }

        // Corpo principal do comprovante
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: RepaintBoundary(
                  key: _invoiceKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context, invoice),
                      const SizedBox(height: 24),
                      _buildTransactionDetails(context, invoice),
                      const SizedBox(height: 24),
                      _buildPartyDetailsCard(
                        context,
                        title: 'Quem Pagou',
                        party: invoice.payer,
                      ),
                      const SizedBox(height: 16),
                      _buildPartyDetailsCard(
                        context,
                        title: 'Quem Recebeu',
                        party: invoice.receiver,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildFooterButtons(context, invoice, _invoiceKey),
          ],
        );
      }),
    );
  }

  // Cabeçalho com Status e Valor
  Widget _buildHeader(BuildContext context, StatementInvoice invoice) {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 50),
          const SizedBox(height: 8),
          AppText.titleMedium(
            context,
            'Transferência realizada com sucesso!',
            color: Colors.grey.shade800,
          ),
          const SizedBox(height: 8),
          AppText.headlineLarge(
            context,
            invoice.amount.toBRL(),
          ),
          const SizedBox(height: 4),
          AppText.bodyMedium(context, invoice.date,
              color: Colors.grey.shade600),
        ],
      ),
    );
  }

  // Detalhes da transação
  Widget _buildTransactionDetails(
      BuildContext context, StatementInvoice invoice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(context, 'Tipo de transação',
            invoice.type.capitalizeFirst ?? invoice.type),
        const Divider(height: 24),
        _buildDetailRow(context, 'Autenticação', invoice.authentication),
      ],
    );
  }

  // Card para Pagador/Recebedor
  Widget _buildPartyDetailsCard(BuildContext context,
      {required String title, required dynamic party}) {
    // party pode ser StatementPayer ou StatementReceiver
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.titleMedium(
              context,
              title,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(context, 'Nome', party.name),
            const SizedBox(height: 8),
            _buildDetailRow(context, 'CPF/CNPJ',
                party.document), // Idealmente formatar com .formatCPF()
            if (party.bankName.isNotEmpty) ...[
              const Divider(height: 24),
              _buildDetailRow(context, 'Instituição', party.bankName),
              const SizedBox(height: 8),
              _buildDetailRow(context, 'Agência', party.agency),
              const SizedBox(height: 8),
              _buildDetailRow(context, 'Conta',
                  '${party.accountNumber}-${party.accountDigit}'),
            ]
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para linhas de detalhe (título e valor)
  Widget _buildDetailRow(BuildContext context, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.bodySmall(context, title, color: Colors.grey.shade600),
        const SizedBox(height: 2),
        AppText.bodyMedium(
          context,
          value,
          color: Colors.grey.shade800,
        ),
      ],
    );
  }

  // Botões no rodapé
  Widget _buildFooterButtons(
      BuildContext context, StatementInvoice invoice, GlobalKey invoiceKey) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.share_outlined),
            label:
                AppText.bodyLarge(context, 'Compartilhar', color: Colors.white),
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              controller.shareInvoiceAsImage(invoiceKey, invoice);
            },
          ),
        ),
      ),
    );
  }
}
