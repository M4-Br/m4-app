import 'package:app_flutter_miban4/data/util/helpers/validators.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/onboarding/validators/phone_confirm_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingPhoneConfirmPage extends StatefulWidget {
  const OnboardingPhoneConfirmPage(
      {super.key,
      this.id,
      this.phonePrefix,
      this.phoneNumber});

  final String? id;
  final String? phonePrefix;
  final String? phoneNumber;

  @override
  State<OnboardingPhoneConfirmPage> createState() => _OnboardingPhoneConfirmPageState();
}

class _OnboardingPhoneConfirmPageState extends State<OnboardingPhoneConfirmPage> with ValidationsMixin {
  late List<TextEditingController> _codeControllers;
  late List<FocusNode> _focusNodes;
  String code = '';
  final PhoneConfirmController _phoneConfirmController =
      Get.put(PhoneConfirmController());
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _codeControllers = [for (int i = 0; i < 6; i++) TextEditingController()];
    _focusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < _codeControllers.length; i++) {
      _codeControllers[i].addListener(() {
        setState(() {
          code = _codeControllers.map((controller) => controller.text).join();
          isButtonEnabled = code.length == 6;
        });
        if (_codeControllers[i].text.length == 1) {
          if (i < _codeControllers.length - 1) {
            FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
          }
        }
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: SafeArea(
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                AppLocalizations.of(context)!.phone_confirm,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.email_send_code,
              style: const TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                AppLocalizations.of(context)!.email_perhaps,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.email_insert_code,
              style: const TextStyle(fontSize: 12),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < 6; i++)
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: TextFormField(
                        focusNode: _focusNodes[i],
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        cursorColor: secondaryColor,
                        controller: _codeControllers[i],
                        keyboardType: TextInputType.number,
                        validator: isNotEmpty,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 22),
                        decoration: const InputDecoration(
                          counterText: '',
                          prefixText: "",
                          isDense: true,
                          border: InputBorder.none,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: secondaryColor),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          contentPadding: EdgeInsets.zero,
                          labelStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          ),
                          hintText: '',
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                ],
              ),
            ),
            const Spacer(),
            Obx(
              () => _phoneConfirmController.isLoading.value == false
                  ? ElevatedButton(
                      onPressed: isButtonEnabled ? _sendConfirmation : null,
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
                          AppLocalizations.of(context)!.next,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : const CircularProgressIndicator(
                      color: secondaryColor,
                    ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.email_send,
                style: const TextStyle(
                    color: Colors.black54,
                    decoration: TextDecoration.underline,
                    fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendConfirmation() async {
    print("${widget.id} ${widget.phonePrefix} ${widget.phoneNumber}");

    try {
      _phoneConfirmController.confirmPhone(
          widget.id!, widget.phonePrefix!, widget.phoneNumber!, code);
    } catch (error) {
      throw Exception(error);
    }
  }
}
