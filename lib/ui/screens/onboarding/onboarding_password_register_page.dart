import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/onboarding/validators/create_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPasswordRegisterPage extends StatefulWidget {
  final int? page;

  const OnboardingPasswordRegisterPage({super.key, this.page});

  @override
  State<OnboardingPasswordRegisterPage> createState() => _OnboardingPasswordRegisterPageState();
}

class _OnboardingPasswordRegisterPageState extends State<OnboardingPasswordRegisterPage> {
  final _fromKey = GlobalKey<FormState>();

  String valuePassword = '';
  String valueConfirmPassword = '';

  bool visibilityTop = true;
  bool visibilityDown = true;

  String id = '';
  String cpf = '';

  final passwordController = TextEditingController();
  final passwordControllerVerify = TextEditingController();
  final CreatePasswordController _createPasswordController =
      Get.put(CreatePasswordController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    passwordControllerVerify.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: widget.page == 1
            ? SafeArea(
                child: Text(
                  'password_register_cnpj'
                      .toUpperCase().tr,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            : null,
        backgroundColor: widget.page == 1 ? primaryColor : Colors.white,
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
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'password_create'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'password_need'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Form(
              key: _fromKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  TextFormField(
                    cursorColor: secondaryColor,
                    controller: passwordController,
                    keyboardType: const TextInputType.numberWithOptions(),
                    maxLength: 6,
                    obscureText: visibilityTop,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                        labelStyle: const TextStyle(
                            color: Colors.black54, fontSize: 15),
                        focusColor: secondaryColor,
                        counterText: '',
                        isDense: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visibilityTop = !visibilityTop;
                            });
                          },
                          icon: visibilityTop
                              ? const Icon(
                                  Icons.visibility_off,
                                  size: 24,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  size: 24,
                                ),
                          color: secondaryColor,
                        ),
                        border: InputBorder.none,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding: EdgeInsets.zero,
                        hintText: '',
                        labelText: 'password'.tr),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'password_create'.tr;
                      } else if (value.length < 6) {
                        return 'password_six'.tr;
                      } else {
                        valuePassword = value;
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: TextFormField(
                      cursorColor: secondaryColor,
                      controller: passwordControllerVerify,
                      keyboardType: const TextInputType.numberWithOptions(),
                      maxLength: 6,
                      obscureText: visibilityDown,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                          labelStyle: const TextStyle(
                              color: Colors.black54, fontSize: 15),
                          counterText: '',
                          isDense: true,
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                visibilityDown = !visibilityDown;
                              });
                            },
                            icon: visibilityDown
                                ? const Icon(
                                    Icons.visibility_off,
                                    size: 24,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    size: 24,
                                  ),
                            color: secondaryColor,
                          ),
                          border: InputBorder.none,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: secondaryColor),
                          ),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          contentPadding: EdgeInsets.zero,
                          hintText: '',
                          labelText:
                              'password_confirm'.tr),
                      validator: (valueConfirm) {
                        if (valueConfirm!.isEmpty) {
                          return 'password_again'.tr;
                        } else if (valueConfirm != valuePassword) {
                          return 'password_equals'.tr;
                        } else {
                          valueConfirmPassword = valueConfirm;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Obx(() => _createPasswordController.isLoading.value == false
                ? ElevatedButton(
                    onPressed: () async {
                      widget.page == 1
                          ? _registerCnpjPassword()
                          : _registerPassword();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        alignment: Alignment.bottomCenter,
                        minimumSize: const Size(double.infinity, 50)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'next'.tr,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  )
                : const CircularProgressIndicator(
                    color: secondaryColor,
                  )),
          ],
        ),
      ),
    );
  }

  Future<void> _registerPassword() async {
    if (_fromKey.currentState!.validate()) {
      try {
        _createPasswordController.createPassword(
            valuePassword, valueConfirmPassword);
      } catch (error) {
        throw Exception(error);
      }
    }
  }

  Future<void> _registerCnpjPassword() async {
    if (_fromKey.currentState!.validate()) {
      try {
        _createPasswordController.createCnpjPassword(
            valuePassword, valueConfirmPassword, context);
      } catch (error) {
        throw Exception(error);
      }
    }
  }
}
