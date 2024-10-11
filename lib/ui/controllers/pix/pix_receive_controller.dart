import 'package:app_flutter_miban4/data/api/pix/pixCreateQRCode.dart';
import 'package:app_flutter_miban4/data/api/pix/pixKeys.dart';
import 'package:app_flutter_miban4/data/model/pix/pixKeys.dart';
import 'package:app_flutter_miban4/data/model/pix/pixReceiveQRCode.dart';
import 'package:get/get.dart';

class PixReceiveController extends GetxController {
  var isLoading = false.obs;
  RxList<PhoneKey> phones = <PhoneKey>[].obs;
  RxList<Document> documents = <Document>[].obs;
  RxList<Email> emails = <Email>[].obs;
  RxList<Evp> evps = <Evp>[].obs;
  RxList<String> listKeys = <String>[].obs;

  var codeLoading = false.obs;

  // Method to get keys
  Future<void> getKeys() async {
    isLoading.value = true;
    listKeys.clear();

    try {
      PixKeys keys = await fetchPixKeys();
      if (keys.success == true) {
        // Populate lists
        phones.value = keys.phones;
        documents.value = keys.documents;
        emails.value = keys.emails;
        evps.value = keys.evps;

        // Create a consolidated list of keys
        final newList = <String>[];
        newList.addAll(phones.map((phone) => phone.key));
        newList.addAll(emails.map((email) => email.key));
        newList.addAll(documents.map((document) => document.key));
        newList.addAll(evps.map((evp) => evp.key));

        // Set the consolidated list
        listKeys.value = newList;
      }
    } catch (error, stackTrace) {
      isLoading(false);
    } finally {
      isLoading.value = false;
    }
  }

  // Method to create PIX code
  Future<CreatePIXQrCode?> createCode(
      String key, String? amount, String? title, String? description) async {
    codeLoading.value = true;

    try {
      CreatePIXQrCode qrCode =
      await createPIXQrCode(key, amount, title, description);
      if (qrCode.success == true) {
        return qrCode;
      }
    } catch (error, stackTrace) {
      codeLoading(false);
    } finally {
      codeLoading.value = false;
    }
  }
}
