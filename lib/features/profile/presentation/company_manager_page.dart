import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/mask.dart';
import 'package:app_flutter_miban4/features/profile/controller/company_manager_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyManagerPage extends GetView<CompanyManagerController> {
  const CompanyManagerPage({super.key});

  final Color _bluePrimary = const Color(0xFF3B82F6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBar(title: 'Gerenciar Empresas'),
      body: Obx(() {
        final company = controller.currentCompany.value;

        return CustomPageBody(
          padding: const EdgeInsets.all(24),
          enableIntrinsicHeight: true,
          children: [
            const Text(
              'Sua Empresa Atual',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            if (controller.isLoading.value && company == null)
              const Center(child: CircularProgressIndicator())
            else if (company != null && company.document.isNotEmpty)
              _buildCompanyCard(company)
            else
              _buildEmptyState(),

            const Spacer(),

            // Botão para cadastrar uma OUTRA empresa (Nova)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showAddCompanyModal(context),
                icon: Icon(Icons.add_business, color: _bluePrimary),
                label: Text('CADASTRAR NOVA EMPRESA',
                    style: TextStyle(
                        color: _bluePrimary, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: _bluePrimary, width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildCompanyCard(dynamic company) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(company.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(
                        'CNPJ: ${MaskUtil.applyMask(company.document, '##.###.###/####-##')}',
                        style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded,
              color: Colors.orange.shade700, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Você não tem nenhum CNPJ vinculado no momento.',
              style: TextStyle(color: Colors.orange.shade900, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // --- MODAL DE CADASTRO ---
  void _showAddCompanyModal(BuildContext context) {
    Get.bottomSheet(
      isScrollControlled:
          true, // Permite que o modal ocupe mais espaço (útil pra formulários)
      Container(
        height: MediaQuery.of(context).size.height * 0.85, // 85% da tela
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Nova Empresa',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints()),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField('CNPJ', controller.cnpjController,
                        mask: cnpjMaskFormatter),
                    const SizedBox(height: 12),
                    _buildTextField(
                        'Razão Social', controller.razaoSocialController),
                    const SizedBox(height: 12),
                    _buildTextField('Nome Fantasia (Opcional)',
                        controller.nomeFantasiaController),
                    const SizedBox(height: 12),
                    _buildTextField(
                        'E-mail de Contato', controller.emailController,
                        isEmail: true),
                    const SizedBox(height: 12),
                    _buildTextField('Telefone', controller.phoneController,
                        mask: phoneMaskFormatter),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.submitNewCompany,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _bluePrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                        : const Text('CADASTRAR EMPRESA',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController textController,
      {dynamic mask, bool isEmail = false}) {
    return TextField(
      controller: textController,
      inputFormatters: mask != null ? [mask] : null,
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : (mask != null ? TextInputType.number : TextInputType.text),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
