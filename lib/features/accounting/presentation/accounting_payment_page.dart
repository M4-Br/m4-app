// lib/features/accounting/page/accounting_payment_page.dart

import 'package:app_flutter_miban4/features/accounting/controller/accounting_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';

class AccountingPaymentPage extends GetView<AccountingPaymentController> {
  const AccountingPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBar(title: 'PAGAMENTO DE IMPOSTO'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Obx(() {
          final data = controller.paymentData;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeaderSection(),
              const SizedBox(height: 32),

              _buildDetailRow('CNPJ', data['cnpj'].toString()),
              _buildDivider(),
              _buildDetailRow('Período de Apuração', data['period'].toString()),
              _buildDivider(),
              _buildDetailRow('Data de Vencimento', data['dueDate'].toString()),
              _buildDivider(),

              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const Text('Valor Total a Pagar',
                        style: TextStyle(fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 8),
                    Text(
                      "R\$ ${data['totalValue'].toString()}",
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Área do Código de Barras [cite: 80, 81]
              const Text(
                'Código de Barras para Pagamento',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        data['barcode'].toString(),
                        style: const TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: secondaryColor),
                      onPressed: controller.copyBarcode,
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Nota de Responsabilidade
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline,
                        color: Colors.orange, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Nota: As informações fornecidas para o pagamento desta DARF são de inteira responsabilidade do usuário.',
                        style:
                            TextStyle(fontSize: 12, color: Colors.orange[900]),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Botão de Ação
              AppButton(
                labelText: 'CONFIRMAR PAGAMENTO',
                onPressed: controller.confirmPayment,
                isLoading: controller.isLoading.value,
                color: primaryColor,
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return const Column(
      children: [
        Icon(Icons.account_balance_wallet_outlined,
            size: 48, color: secondaryColor),
        SizedBox(height: 16),
        Text(
          'Pagamento de DARF',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Simples Nacional',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.black54, fontSize: 14)),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, color: Colors.black12);
  }
}
