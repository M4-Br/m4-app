import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/TED/model/transfer_contacts_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TransferContactsController extends BaseController {
  final RxList<TransferContactsModel> contacts = <TransferContactsModel>[].obs;

  final _box = GetStorage();
  final String _storageKey = 'saved_transfer_contacts';

  @override
  void onInit() {
    super.onInit();
    loadContacts();
  }

  void loadContacts() {
    isLoading(true);
    try {
      List<dynamic>? storedList = _box.read<List<dynamic>>(_storageKey);

      if (storedList != null) {
        contacts.assignAll(
            storedList.map((e) => TransferContactsModel.fromJson(e)).toList());
      }
    } catch (e, s) {
      AppLogger.I().error('Erro ao carregar contatos de TED', e, s);
    } finally {
      isLoading(false);
    }
  }

  Future<void> addContact(TransferContactsModel newContact) async {
    contacts.add(newContact);
    await _saveToStorage();
  }

  Future<void> removeContact(int index) async {
    contacts.removeAt(index);
    await _saveToStorage();
  }

  Future<void> _saveToStorage() async {
    final jsonList = contacts.map((e) => e.toJson()).toList();
    await _box.write(_storageKey, jsonList);
  }

  void goToNewContact() {
    Get.toNamed(AppRoutes.transferNewContact)?.then((_) => loadContacts());
  }

  void onContactSelected(TransferContactsModel contact) {
    Get.toNamed(AppRoutes.transferValueAndConfirm, arguments: contact);
  }
}
