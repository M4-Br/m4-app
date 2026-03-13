import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/clients/model/clients_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:app_flutter_miban4/features/clients/model/client_model.dart';

class ClientsController extends BaseController {
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'local_clients_db';

  String get currentUserId =>
      userRx.userId.toString(); // Substitua pelo seu ID de auth real

  final RxList<ClientModel> allClients = <ClientModel>[].obs;
  final RxList<ClientModel> filteredClients = <ClientModel>[].obs;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cpfController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final notesController = TextEditingController();
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadClients();
  }

  void _loadClients() {
    List<dynamic> storedData = _storage.read<List<dynamic>>(_storageKey) ?? [];
    List<ClientModel> allStordedClients =
        storedData.map((item) => ClientModel.fromMap(item)).toList();

    allClients.assignAll(
        allStordedClients.where((c) => c.userId == currentUserId).toList());
    filteredClients.assignAll(allClients);
  }

  // --- PREPARA O FORMULÁRIO PARA CRIAR OU EDITAR ---
  void prepareForm([ClientModel? client]) {
    if (client != null) {
      nameController.text = client.name;
      phoneController.text = client.phone;
      cpfController.text = client.cpf;
      emailController.text = client.email;
      addressController.text = client.address;
      notesController.text = client.notes;
    } else {
      _clearForm();
    }
  }

  // --- SALVA (NOVO OU EDIÇÃO) ---
  void saveClient({String? existingId}) {
    if (!formKey.currentState!.validate()) return;

    final clientToSave = ClientModel(
      id: existingId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      userId: currentUserId,
      name: nameController.text.trim(),
      phone: phoneController.text.trim(), // O texto já vem com a máscara!
      cpf: cpfController.text.trim(), // O texto já vem com a máscara!
      email: emailController.text.trim(),
      address: addressController.text.trim(),
      notes: notesController.text.trim(),
    );

    List<dynamic> storedData = _storage.read<List<dynamic>>(_storageKey) ?? [];

    if (existingId != null) {
      // É uma EDIÇÃO: Atualiza na lista em memória e no GetStorage
      int index = allClients.indexWhere((c) => c.id == existingId);
      if (index != -1) allClients[index] = clientToSave;

      int storageIndex =
          storedData.indexWhere((item) => item['id'] == existingId);
      if (storageIndex != -1) storedData[storageIndex] = clientToSave.toMap();
    } else {
      // É um NOVO CLIENTE
      allClients.insert(0, clientToSave);
      storedData.add(clientToSave.toMap());
    }

    _storage.write(_storageKey, storedData);

    searchController.clear();
    filterClients('');
    _clearForm();
    Get.back(); // Fecha o modal

    Get.snackbar(
      'Sucesso',
      existingId == null
          ? 'Cliente cadastrado com sucesso!'
          : 'Cliente atualizado!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void filterClients(String query) {
    if (query.isEmpty) {
      filteredClients.assignAll(allClients);
    } else {
      query = query.toLowerCase();
      filteredClients.assignAll(allClients.where((c) {
        return c.name.toLowerCase().contains(query) ||
            c.phone.contains(query) ||
            c.email.toLowerCase().contains(query);
      }).toList());
    }
  }

  void _clearForm() {
    nameController.clear();
    phoneController.clear();
    cpfController.clear();
    emailController.clear();
    addressController.clear();
    notesController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    cpfController.dispose();
    emailController.dispose();
    addressController.dispose();
    notesController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
