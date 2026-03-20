import 'package:app_flutter_miban4/core/helpers/formatters/currency_formatter.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/features/profile/controller/financial_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FinancialDataPage extends GetView<FinancialController> {
  final String? groupID;

  const FinancialDataPage({super.key, this.groupID});

  final Color _greenDark = const Color(0xFF065F46);
  final Color _bgLight = const Color(0xFFF8F9FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: AppBar(
        backgroundColor: _greenDark,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'account_data'.tr,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: AppLoading());
        }

        if (controller.userCapacity.value == null ||
            controller.userParams.value == null) {
          return const Center(
              child: Text('Erro ao carregar dados financeiros'));
        }

        final updateDate = controller.userCapacity.value?.updateDate;
        final formattedDate = updateDate != null
            ? DateFormat('dd/MM/yyyy').format(DateTime.parse(updateDate))
            : 'Nunca atualizado';

        return Stack(
          children: [
            // 1. Fundo verde estendido (igual ao Perfil)
            Container(
              height: 100,
              width: double.infinity,
              color: _greenDark,
            ),

            // 2. Conteúdo em Cards
            Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      // --- CARD 1: INFORMAÇÕES GERAIS ---
                      _buildFormCard(
                        title: 'financial_info'.tr.toUpperCase(),
                        subtitle: 'Última atualização: $formattedDate',
                        children: [
                          _buildDropdownRow(
                            label: 'financial_house'.tr.toUpperCase(),
                            value: controller.selectedHomeType.value,
                            items: controller.dropdownHouse,
                            onChanged: (val) =>
                                controller.selectedHomeType.value = val,
                          ),
                          _buildDivider(),
                          _buildDropdownRow(
                            label: 'financial_transport'.tr.toUpperCase(),
                            value: controller.selectedTransport.value,
                            items: controller.dropdownTransport,
                            onChanged: (val) =>
                                controller.selectedTransport.value = val,
                          ),
                          _buildDivider(),
                          _buildInputRow(
                            label: 'financial_income'.tr.toUpperCase(),
                            controller: controller.incomeController,
                            isCurrency: true,
                          ),
                          _buildDivider(),
                          _buildInputRow(
                            label: 'financial_family'.tr.toUpperCase(),
                            controller: controller.familySizeController,
                            isCurrency: false,
                            hintText: 'Qtd',
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // --- CARD 2: DESPESAS ---
                      _buildFormCard(
                        title: 'financial_expenses'.tr.toUpperCase(),
                        children: [
                          _buildInputRow(
                            label: 'financial_house'.tr.toUpperCase(),
                            controller: controller.houseCostsController,
                            isCurrency: true,
                          ),
                          _buildDivider(),
                          _buildInputRow(
                            label: 'financial_transport'.tr.toUpperCase(),
                            controller: controller.transportCostsController,
                            isCurrency: true,
                          ),
                          _buildDivider(),
                          _buildInputRow(
                            label: 'financial_utilities'.tr.toUpperCase(),
                            controller: controller.utilityCostsController,
                            isCurrency: true,
                          ),
                          _buildDivider(),
                          _buildInputRow(
                            label:
                                'financial_another_expenses'.tr.toUpperCase(),
                            controller: controller.otherCostsController,
                            isCurrency: true,
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // --- BOTÃO DE CONFIRMAR ---
                      SizedBox(
                        height: 52,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.isButtonEnabled.value &&
                                  !controller.isPosting.value
                              ? () => controller.postFinancial(groupID)
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _greenDark,
                            disabledBackgroundColor: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          child: controller.isPosting.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                      color: Colors.white, strokeWidth: 2))
                              : Text(
                                  'confirm'.tr.toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),

                      const SizedBox(height: 40), // Respiro final da página
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  // --- COMPONENTES VISUAIS AUXILIARES ---

  // O Card Branco com Sombra que abraça os formulários
  Widget _buildFormCard(
      {required String title,
      String? subtitle,
      required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
          ],
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDivider() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Divider(height: 1, color: Colors.grey.shade100),
      );

  Widget _buildDropdownRow(
      {required String label,
      required String? value,
      required List<DropdownMenuItem<String>> items,
      required Function(String?) onChanged}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Text(label,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87)),
        ),
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA), // Fundo levinho pro input
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.transparent),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down,
                    size: 20, color: Colors.black38),
                hint: const Text('Selecione', style: TextStyle(fontSize: 14)),
                items: items,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputRow(
      {required String label,
      required TextEditingController controller,
      required bool isCurrency,
      String hintText = 'R\$ 0,00'}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Text(label,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87)),
        ),
        Expanded(
          flex: 5,
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.right,
            keyboardType: const TextInputType.numberWithOptions(),
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w600),
            inputFormatters: isCurrency
                ? [FilteringTextInputFormatter.digitsOnly, CurrencyFormatter()]
                : [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              isDense: true,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              filled: true,
              fillColor: const Color(0xFFF8F9FA), // Fundo levinho pro input
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: const Color(0xFF065F46).withValues(alpha: 0.3))),
            ),
          ),
        ),
      ],
    );
  }
}
