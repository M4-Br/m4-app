import 'package:app_flutter_miban4/core/helpers/formatters/mask.dart';
import 'package:app_flutter_miban4/features/clients/controller/clients_controller.dart';
import 'package:app_flutter_miban4/features/clients/model/clients_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:app_flutter_miban4/features/clients/controller/clients_controller.dart';
// import 'package:app_flutter_miban4/features/clients/model/client_model.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
// IMPORTANTE: Importe o seu arquivo de formatação aqui!
// import 'package:app_flutter_miban4/core/helpers/utils/mask_util.dart';

class ClientsPage extends GetView<ClientsController> {
  const ClientsPage({super.key});

  final Color _darkHeader = const Color(0xFF1E293B);
  final Color _bgLight = const Color(0xFFF8F9FA);
  final Color _textDark = const Color(0xFF1F2937);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: AppBar(
        backgroundColor: _darkHeader,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text('Meus Clientes',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          _buildDarkHeader(),
          Expanded(
            child: CustomPageBody(
              enableIntrinsicHeight: false,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                const SizedBox(height: 16),
                _buildSummaryCard(context),
                const SizedBox(height: 24),
                Obx(() {
                  if (controller.filteredClients.isEmpty)
                    return _buildEmptyState();
                  return _buildClientsList(
                      context); // Passando context para o Modal
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDarkHeader() {
    return Container(
      width: double.infinity,
      color: _darkHeader,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 8),
      child: Container(
        decoration: BoxDecoration(
          color:
              Colors.white.withValues(alpha: 0.1), // Ajustado com .withValues!
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: TextField(
          controller: controller.searchController,
          onChanged: controller.filterClients,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Buscar por nome, telefone ou e-mail...',
            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
            prefixIcon:
                Icon(Icons.search, color: Colors.white.withValues(alpha: 0.5)),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: _bgLight, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.people_alt_outlined, color: Colors.black54),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                    '${controller.allClients.length}',
                    style: TextStyle(
                        color: _textDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              const Text('clientes cadastrados',
                  style: TextStyle(color: Colors.black54, fontSize: 12)),
            ],
          ),
          const Spacer(),
          ElevatedButton.icon(
            // Abre o modal de CRIAR (passando null)
            onPressed: () => _showClientDialog(context),
            icon: const Icon(Icons.add, size: 16, color: Colors.white),
            label: const Text('Novo Cliente',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F172A),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 60, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text('Nenhum cliente encontrado',
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Cadastre seu primeiro cliente',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildClientsList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: controller.filteredClients.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final client = controller.filteredClients[index];
        return ListTile(
          // Abre o modal de EDITAR (passando o cliente clicado)
          onTap: () => _showClientDialog(context, client: client),
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade200)),
          leading: CircleAvatar(
            backgroundColor: const Color(0xFF0F172A).withValues(alpha: 0.1),
            child: Text(client.name.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                    color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
          ),
          title: Text(client.name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          // Se o telefone estiver salvo com máscara, já vai aparecer perfeitinho aqui!
          subtitle: Text(client.phone.isNotEmpty ? client.phone : client.email,
              style: const TextStyle(fontSize: 12)),
          trailing: const Icon(Icons.edit_outlined,
              size: 18, color: Colors.grey), // Um hint visual de que é clicável
        );
      },
    );
  }

  // --- MODAL UNIFICADO: NOVO / EDITAR ---
  void _showClientDialog(BuildContext context, {ClientModel? client}) {
    // 1. Preenche os dados no controller (ou limpa se for novo)
    controller.prepareForm(client);

    // 2. Define o título
    final bool isEditing = client != null;

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
                      Text(isEditing ? 'Editar Cliente' : 'Novo Cliente',
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
                  _buildTextField(
                      label: 'Nome completo *',
                      controller: controller.nameController,
                      isRequired: true),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                          child: _buildTextField(
                        label: 'Telefone / WhatsApp',
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        // --- AQUI ENTRA A SUA MÁSCARA ---
                        inputFormatters: [phoneMaskFormatter],
                      )),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildTextField(
                        label: 'CPF',
                        controller: controller.cpfController,
                        keyboardType: TextInputType.number,
                        // --- E AQUI A DO CPF ---
                        inputFormatters: [cpfMaskFormatter],
                      )),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                      label: 'E-mail',
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 12),
                  _buildTextField(
                      label: 'Endereço',
                      controller: controller.addressController),
                  const SizedBox(height: 12),
                  _buildTextField(
                      label: 'Observações',
                      controller: controller.notesController,
                      maxLines: 3),
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
                      ElevatedButton(
                        // Chama o salvar repassando o ID se estiver editando
                        onPressed: () =>
                            controller.saveClient(existingId: client?.id),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade600,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(isEditing ? 'Atualizar' : 'Salvar',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
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

  // Modificado para aceitar os InputFormatters
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
      inputFormatters: inputFormatters, // <-- Repassando pro TextFormField
      validator: isRequired
          ? (value) => value!.isEmpty ? 'Campo obrigatório' : null
          : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF0F172A))),
      ),
    );
  }
}
