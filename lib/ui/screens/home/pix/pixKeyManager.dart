import 'package:app_flutter_miban4/data/api/pix/pixDeleteKey.dart';
import 'package:app_flutter_miban4/data/api/pix/pixKeys.dart';
import 'package:app_flutter_miban4/data/model/pix/pixDelete.dart';
import 'package:app_flutter_miban4/data/model/pix/pixKeys.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixAddKeys.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PixKeyManager extends StatefulWidget {
  const PixKeyManager({super.key});

  @override
  State<PixKeyManager> createState() => _PixKeyManagerState();
}

class _PixKeyManagerState extends State<PixKeyManager> {
  var _isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: 'pix_keyManager'.tr,
        backPage: () => Get.off(() => PixHome(), transition: Transition.leftToRight),
      ),
      body: Container(
        color: const Color(0xFFe9eaf0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder<PixKeys>(
                future: fetchPixKeys(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Erro na chamada da API'),
                    );
                  } else {
                    PixKeys keys = snapshot.data!;

                    int totalKeys = keys.phones.length +
                        keys.documents.length +
                        keys.emails.length +
                        keys.evps.length;

                    if (keys.success == false) {
                      return Center(
                        child: Text('pix_noKeys'.tr),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: totalKeys,
                      itemBuilder: (context, index) {
                        int groupStartIndex = 0;
                        int groupEndIndex = keys.phones.length;
                        String groupTitle =
                            'pix_phoneKey'.tr;

                        if (index >= groupEndIndex) {
                          groupStartIndex = groupEndIndex;
                          groupEndIndex += keys.documents.length;
                          groupTitle =
                              'pix_documentKey'.tr;
                        }

                        if (index >= groupEndIndex) {
                          groupStartIndex = groupEndIndex;
                          groupEndIndex += keys.emails.length;
                          groupTitle =
                              'pix_emailKey'.tr;
                        }

                        if (index >= groupEndIndex) {
                          groupStartIndex = groupEndIndex;
                          groupEndIndex += keys.evps.length;
                          groupTitle =
                              'pix_randomKey'.tr;
                        }

                        bool isFirstInGroup = index == groupStartIndex;

                        if (index < keys.phones.length) {
                          PhoneKey phone = keys.phones[index];
                          if (phone.key.isNotEmpty) {
                            return Column(
                              children: [
                                if (isFirstInGroup)
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      groupTitle,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                buildKeyContainer(
                                    phone.key, phoneMaskFormatter),
                              ],
                            );
                          }
                        } else if (index <
                            keys.phones.length + keys.documents.length) {
                          int documentIndex = index - keys.phones.length;
                          Document document = keys.documents[documentIndex];
                          if (document.key.isNotEmpty) {
                            return Column(
                              children: [
                                if (isFirstInGroup)
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      groupTitle,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                buildKeyContainer(
                                    document.key, cpfMaskFormatter),
                              ],
                            );
                          }
                        } else if (index <
                            keys.phones.length +
                                keys.documents.length +
                                keys.emails.length) {
                          int emailIndex = index -
                              keys.phones.length -
                              keys.documents.length;
                          Email email = keys.emails[emailIndex];
                          if (email.key.isNotEmpty) {
                            return Column(
                              children: [
                                if (isFirstInGroup)
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      groupTitle,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                buildKeyContainer(email.key, noneFormatter),
                              ],
                            );
                          }
                        } else {
                          int evpIndex = index -
                              keys.phones.length -
                              keys.documents.length -
                              keys.emails.length;
                          Evp evp = keys.evps[evpIndex];
                          if (evp.key.isNotEmpty) {
                            return Column(
                              children: [
                                if (isFirstInGroup)
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      groupTitle,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                buildKeyContainer(evp.key, noneFormatter),
                              ],
                            );
                          }
                        }
                        return Text(
                          'pix_haveNot'.tr,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Center(
              child: Text(
                'pix_fiveKeys'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                  child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const PixAddKeys(),
                      transition: Transition.rightToLeft);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.bottomCenter,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'pix_createNewKey'.tr,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildKeyContainer(String key, MaskTextInputFormatter mask) {
    TextEditingController controller =
        TextEditingController(text: mask.maskText(key));

    controller.addListener(() {
      mask.formatEditUpdate(
        const TextEditingValue(),
        TextEditingValue(text: controller.text),
      );
    });

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        child: Row(
          children: [
            Text(
              controller.text.length > 25
                  ? "${controller.text.substring(0, 25)}..."
                  : controller.text,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Container(
              color: Colors.grey,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: key.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('pix_keyCopied'.tr),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'pix_sureDelete'.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    'pix_keyExclude'.tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                                Obx(() => _isLoading.value == false
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: SizedBox(
                                              height: 30,
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      secondaryColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                child: Text(
                                                  'pix_stayWithKey'.tr,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                try {
                                                  _isLoading(true);
                                                  PixDeleteModel result =
                                                      await deletePixKey(key);
                                                  if (result.success == true) {
                                                    _isLoading(false);
                                                    Get.back();
                                                    _dialogResult(
                                                        context,
                                                        'dialog_success'.tr,
                                                        result.message);
                                                  } else {
                                                    _isLoading(false);
                                                    Get.back();
                                                    _dialogResult(
                                                        context,
                                                        'dialog_error'.tr,
                                                        result.message);
                                                  }
                                                } catch (error) {
                                                  _isLoading(false);
                                                  Get.back();
                                                  _dialogResult(
                                                      context,
                                                      'dialog_someError'.tr,
                                                      error.toString());
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.redAccent.shade700,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                              child: Text(
                                                'pix_deleteKey'.tr,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(
                                          color: secondaryColor,
                                        ),
                                      )),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _dialogResult(BuildContext context, String title, String message) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog.adaptive(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.bottomCenter),
                    child: const Center(
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
