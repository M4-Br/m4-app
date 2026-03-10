import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';
import 'package:app_flutter_miban4/features/partners/controller/partner_sale_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartnerSaleHistoryPage extends GetView<PartnerSaleHistoryController> {
  const PartnerSaleHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Vendas'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.sales.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Nenhuma venda encontrada.'),
                TextButton(
                  onPressed: controller.fetchSales,
                  child: const Text('Atualizar'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchSales,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.sales.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final sale = controller.sales[index];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  child: Icon(Icons.receipt_long_outlined, color: Colors.white),
                ),
                title: Text(sale.product?.productName ??
                    'Venda #${sale.transactionId}'),
                subtitle: Text(
                    'Data: ${sale.saleDate.day}/${sale.saleDate.month}/${sale.saleDate.year}'),
                trailing: Text(
                  (sale.totalValue / 100).toBRL(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
