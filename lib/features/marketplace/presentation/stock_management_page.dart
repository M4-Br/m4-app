import 'package:app_flutter_miban4/core/helpers/formatters/currency_formatter.dart';
import 'package:app_flutter_miban4/features/marketplace/controller/stock_management_controller.dart';
import 'package:app_flutter_miban4/features/marketplace/model/partners_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';

class StockManagementPage extends GetView<StockManagementController> {
  const StockManagementPage({super.key});

  final Color _greenDark = const Color(0xFF065F46);
  final Color _bgLight = const Color(0xFFF8F9FA);
  final Color _textDark = const Color(0xFF1F2937);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: AppBar(
        backgroundColor: _greenDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: CustomPageBody(
              enableIntrinsicHeight: false,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                const SizedBox(height: 16),
                _buildSummaryCards(),
                const SizedBox(height: 16),
                _buildAlertBanner(),
                const SizedBox(height: 24),
                _buildSearchBar(),
                const SizedBox(height: 16),
                Obx(() {
                  // AJUSTE 1: Alterado de allProducts para myProducts
                  if (controller.isLoading.value &&
                      controller.myProducts.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.filteredProducts.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('Nenhum produto encontrado.',
                          style: TextStyle(color: Colors.grey)),
                    );
                  }
                  return _buildProductsList(context);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- CABEÇALHO COM BOTÃO ---
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: _greenDark,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Controle de Estoque',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('Gerencie seus produtos',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () => _showProductDialog(context),
            icon: const Icon(Icons.add, size: 16, color: Color(0xFF065F46)),
            label: const Text('Novo Produto',
                style: TextStyle(
                    color: Color(0xFF065F46), fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  // --- CARDS DE RESUMO ---
  Widget _buildSummaryCards() {
    return Obx(() {
      // AJUSTE 2: Força o GetX a observar a lista, evitando o erro de tela vermelha
      final _ = controller.myProducts.length;

      return GridView(
        shrinkWrap: true,
        primary: false,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: 80,
        ),
        children: [
          _buildMetricCard('Total de Produtos',
              controller.totalProducts.toString(), Colors.black87),
          _buildMetricCard('Estoque Baixo', controller.lowStockCount.toString(),
              Colors.deepOrange),
          _buildMetricCard(
              'Valor em Estoque',
              'R\$ ${controller.totalStockValue.toStringAsFixed(2).replaceAll('.', ',')}',
              const Color(0xFF059669)),
        ],
      );
    });
  }

  Widget _buildMetricCard(String title, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  color: valueColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // --- ALERTA LARANJA ---
  Widget _buildAlertBanner() {
    return Obx(() {
      // AJUSTE 3: Garante a leitura de um observável (myProducts) para o GetX não quebrar
      if (controller.myProducts.isEmpty || controller.lowStockCount == 0) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF7ED),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFFFEDD5)),
        ),
        child: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.deepOrange),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Alerta de Estoque Baixo',
                    style: TextStyle(
                        color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                Text(
                    '${controller.lowStockCount} produto(s) com estoque abaixo do mínimo',
                    style: const TextStyle(
                        color: Colors.deepOrange, fontSize: 12)),
              ],
            )
          ],
        ),
      );
    });
  }

  // --- BARRA DE BUSCA BRANCA ---
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller.searchController,
        onChanged: controller.filterProducts,
        decoration: InputDecoration(
          hintText: 'Buscar produtos...',
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  // --- LISTA DE PRODUTOS ---
  Widget _buildProductsList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: controller.filteredProducts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = controller.filteredProducts[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2))
            ],
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: const Color(0xFFD1FAE5),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.inventory_2_outlined,
                        color: Color(0xFF059669)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name,
                            style: TextStyle(
                                color: _textDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(4),
                                  border:
                                      Border.all(color: Colors.grey.shade300)),
                              child: Text('SKU: ${item.id}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey.shade700)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined,
                        size: 20, color: Colors.black54),
                    onPressed: () => _showProductDialog(context, item: item),
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.only(right: 8),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline,
                        size: 20, color: Colors.red),
                    onPressed: () => controller.confirmDeletion(
                        item), // AJUSTE 4: Deletando de verdade!
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildItemDetail(
                      'Preço Venda',
                      'R\$ ${item.marketValue.toStringAsFixed(2).replaceAll('.', ',')}',
                      const Color(0xFF059669)),
                  _buildItemDetail(
                      'Valor Parceiro',
                      'R\$ ${item.marketplaceValue.toStringAsFixed(2).replaceAll('.', ',')}',
                      Colors.black87),
                  _buildItemDetail(
                      'Desconto',
                      'R\$ ${item.discount.toStringAsFixed(2).replaceAll('.', ',')}',
                      Colors.blue),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildItemDetail(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.black54, fontSize: 11)),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                color: valueColor, fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }

  // --- MODAL: NOVO / EDITAR PRODUTO ---
  void _showProductDialog(BuildContext context, {MarketplaceItem? item}) {
    controller.prepareForm(item);
    final bool isEditing = item != null;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(isEditing ? 'Editar Produto' : 'Novo Produto',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A))),
                      IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          onPressed: () => Get.back(),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints()),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Campo Categoria
                  Obx(() => Column(
                        children: [
                          DropdownButtonFormField<MarketplaceCategory>(
                            decoration: _inputDecoration('Categoria'),
                            initialValue: controller.selectedCategory.value,
                            items: controller.availableCategories.map((cat) {
                              return DropdownMenuItem(
                                value: cat,
                                child: Text(cat.categoryName,
                                    style: TextStyle(
                                        color: cat.id == -1
                                            ? const Color(0xFF059669)
                                            : Colors.black87,
                                        fontWeight: cat.id == -1
                                            ? FontWeight.bold
                                            : FontWeight.normal)),
                              );
                            }).toList(),
                            onChanged: controller.onCategoryChanged,
                            validator: (val) =>
                                val == null ? 'Obrigatório' : null,
                          ),
                          if (controller.isCreatingCategory.value) ...[
                            const SizedBox(height: 12),
                            _buildTextField(
                                label: 'Nome da Nova Categoria',
                                controller: controller.newCategoryController,
                                isRequired: true),
                          ],
                        ],
                      )),
                  const SizedBox(height: 12),

                  _buildTextField(
                      label: 'Nome do Produto *',
                      controller: controller.nameController,
                      isRequired: true),
                  const SizedBox(height: 12),
                  _buildTextField(
                      label: 'Descrição (opcional)',
                      controller: controller.descriptionController,
                      maxLines: 2),
                  const SizedBox(height: 12),

                  // Valores
                  Row(
                    children: [
                      Expanded(
                          child: _buildTextField(
                        label: 'Valor Atual (R\$)',
                        controller: controller.marketValueController,
                        isRequired: true,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyFormatter()
                        ],
                      )),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildTextField(
                        label: 'Valor Parceiros (R\$)',
                        controller: controller.marketplaceValueController,
                        isRequired: true,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyFormatter()
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Desconto Calculado Visual
                  Obx(() {
                    final discountStr = controller.calculatedDiscount.value
                        .toStringAsFixed(2)
                        .replaceAll('.', ',');
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: const Color(0xFFF0FDF4),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFDCFCE7))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Desconto Calculado:',
                              style: TextStyle(
                                  color: Color(0xFF166534),
                                  fontWeight: FontWeight.w600)),
                          Text('R\$ $discountStr',
                              style: const TextStyle(
                                  color: Color(0xFF166534),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Cancelar',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 12),
                      Obx(() => ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : () => controller.saveProduct(
                                    existingId: item?.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF065F46),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: controller.isLoading.value
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 2))
                                : Text(isEditing ? 'Atualizar' : 'Salvar',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- AJUDANTES DE UI DO MODAL ---
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF0F172A))),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool isRequired = false,
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: isRequired
          ? (value) => value!.isEmpty ? 'Campo obrigatório' : null
          : null,
      decoration: _inputDecoration(label),
    );
  }
}
