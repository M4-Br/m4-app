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
        final company = controller.userRx.company;
        final isReplacing = controller.isReplacingDocument.value;

        return CustomPageBody(
          padding: const EdgeInsets.all(24),
          enableIntrinsicHeight: true,
          children: [
            const Text(
              'Sua Empresa Atual',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            if (company != null && company.document.isNotEmpty)
              _buildCompanyCard(company)
            else
              _buildEmptyState(),

            const SizedBox(height: 32),

            // --- ÁREA DINÂMICA DE ATUALIZAÇÃO ---
            if (isReplacing || company == null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Enviar Novo Cartão CNPJ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if (isReplacing)
                    TextButton(
                      onPressed: controller.cancelReplacement,
                      child: const Text('Cancelar',
                          style: TextStyle(color: Colors.red)),
                    )
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Selecione o arquivo PDF atualizado da sua empresa para validação.',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 16),
              _buildUploadBox(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.selectedFileName.value.isEmpty
                      ? null
                      : controller.uploadPdf,
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
                      : const Text('CONFIRMAR ATUALIZAÇÃO',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                ),
              ),
            ],

            const Spacer(),

            // Botão para cadastrar uma OUTRA empresa (Nova)
            if (!isReplacing)
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
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: _bluePrimary.withValues(alpha: 0.1),
                    shape: BoxShape.circle),
                child: Icon(Icons.business, color: _bluePrimary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(height: 1)),

          // --- BOTÕES DE AÇÃO DO CARD ---
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: controller.viewCurrentPdf,
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  label: const Text('Visualizar'),
                  style: TextButton.styleFrom(foregroundColor: _bluePrimary),
                ),
              ),
              Container(width: 1, height: 20, color: Colors.grey.shade200),
              Expanded(
                child: TextButton.icon(
                  onPressed: controller.toggleReplaceMode,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text('Trocar Doc'),
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.orange.shade700),
                ),
              ),
            ],
          )
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
    // Limpa o mock de arquivo caso o usuário tenha fechado o modal antes
    controller.removePdfFile();

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
                    const SizedBox(height: 24),
                    const Text('Cartão CNPJ (PDF)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    Obx(() => _buildUploadBox()),
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

  Widget _buildUploadBox() {
    final hasFile = controller.selectedFileName.value.isNotEmpty;

    return InkWell(
      onTap: hasFile ? controller.removePdfFile : controller.pickPdfFile,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: hasFile ? Colors.blue.shade50 : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: hasFile ? _bluePrimary : Colors.grey.shade400,
              width: 1.5,
              style: hasFile
                  ? BorderStyle.solid
                  : BorderStyle.none), // pontilhado simulado
        ),
        child: Column(
          children: [
            Icon(
              hasFile ? Icons.file_present : Icons.upload_file,
              color: hasFile ? _bluePrimary : Colors.grey.shade500,
              size: 32,
            ),
            const SizedBox(height: 12),
            Text(
              hasFile
                  ? controller.selectedFileName.value
                  : 'Toque para anexar o PDF',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: hasFile ? _bluePrimary : Colors.grey.shade700,
                fontWeight: hasFile ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
            if (hasFile)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text('Toque para remover',
                    style: TextStyle(color: Colors.red, fontSize: 12)),
              )
          ],
        ),
      ),
    );
  }
}
