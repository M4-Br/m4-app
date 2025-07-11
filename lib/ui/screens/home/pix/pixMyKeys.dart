import 'package:app_flutter_miban4/data/api/pix/pixKeys.dart';
import 'package:app_flutter_miban4/data/model/pix/pixKeys.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixAddKeys.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixKeyManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PixMyKeys extends StatefulWidget {
  const PixMyKeys({Key? key}) : super(key: key);

  @override
  State<PixMyKeys> createState() => _PixMyKeysState();
}

class _PixMyKeysState extends State<PixMyKeys> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: 'pix_myKeys'.tr,
        backPage: () => Get.off(() => const PixKeyManager(), transition: Transition.leftToRight),
        rightIcon: IconButton(
          icon: const Icon(Icons.rule),
          onPressed: () {
            Get.to(() => const PixKeyManager(),
                transition: Transition.rightToLeft);
          },
        ),
      ),
      body: Container(
        color: const Color(0xFFe9eaf0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                'pix_keys'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Expanded(
              flex: 8,
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

                    if (keys.success == false) {
                      return Center(
                        child: Text('pix_noKeys'.tr),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: keys.phones.length +
                          keys.documents.length +
                          keys.emails.length +
                          keys.evps.length,
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
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
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
                    ),
                    child: Text(
                      'pix_createKey'.tr,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
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

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2.0,
      child: InkWell(
        onTap: () {
          Clipboard.setData(ClipboardData(text: key.toString()));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('pix_keyCopied'.tr),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  inputFormatters: [mask],
                  enabled: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const Icon(Icons.copy),
            ],
          ),
        ),
      ),
    );
  }
}
