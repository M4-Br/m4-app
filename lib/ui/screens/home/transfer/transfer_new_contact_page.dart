import 'package:app_flutter_miban4/core/config/auth/controller/user_controller.dart';
import 'package:app_flutter_miban4/core/config/auth/model/user.dart';
import 'package:app_flutter_miban4/data/api/transfer/transferAuth.dart';
import 'package:app_flutter_miban4/data/model/userData/user.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_bank_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_shifter_v2/mask_shifter.dart';

class TransferNewContactPage extends StatefulWidget {
  const TransferNewContactPage({super.key});

  @override
  State<TransferNewContactPage> createState() => _TransferNewContactPageState();
}

class _TransferNewContactPageState extends State<TransferNewContactPage> {
  final TextEditingController _controller = TextEditingController();
  final UserController _userController = Get.put(UserController());

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    User? userData = _userController.user.value;

    return Scaffold(
      appBar: AppBarDefault(
        title: 'transfer'.tr,
        backPage: () => Get.off(() => const TransferContactPage(),
            transition: Transition.leftToRight),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                'transfer_to'.tr,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  'transfer_cpf'.tr,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                cursorColor: const Color(0xFF002A4D),
                inputFormatters: [
                  MaskedTextInputFormatterShifter(
                      maskONE: "XXX.XXX.XXX-XX", maskTWO: "XX.XXX.XXX/XXXX-XX")
                ],
                decoration: InputDecoration(
                  labelText: 'transfer_document'.tr,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF002A4D),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Visibility(
                    visible: _isLoading,
                    child: const CircularProgressIndicator(
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: ElevatedButton(
                onPressed: () async {
                  final document = _controller.text
                      .replaceAll(".", "")
                      .replaceAll("-", "")
                      .replaceAll("/", "")
                      .toString();

                  if (document.isCpf || document.isCnpj) {
                    setState(() {
                      _isLoading = true;
                    });
                    if (document != userData!.user.document) {
                      try {
                        await fetchUser(document).then((userTransfer) {
                          if (userTransfer["id"].toString().isNotEmpty) {
                            setState(() {
                              _isLoading = false;
                            });
                            Get.to(
                                () => TransferBankPage(
                                    userTransfer: userTransfer,
                                    type: 1,
                                    document:
                                        userTransfer['document'].toString()),
                                transition: Transition.rightToLeft);
                          } else {
                            Get.to(
                                () => TransferBankPage(
                                      document: document,
                                      type: 2,
                                    ),
                                transition: Transition.rightToLeft);
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        });
                      } catch (e) {
                        Get.to(
                            () => TransferBankPage(
                                  document: document,
                                  type: 2,
                                ),
                            transition: Transition.rightToLeft);
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    } else {
                      setState(() {
                        _isLoading = false;
                      });
                      Get.to(
                          () => TransferBankPage(
                                document: document,
                                type: 2,
                              ),
                          transition: Transition.rightToLeft);
                    }
                  } else {
                    setState(() {
                      _isLoading = false;
                    });
                    Get.snackbar('message'.tr, 'Documento Inválido',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.white);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  'next'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
