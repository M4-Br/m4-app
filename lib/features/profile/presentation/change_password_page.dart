import 'package:app_flutter_miban4/data/api/password/change_password.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _passwordObscure = true.obs;
  var _newPasswordObscure = true.obs;
  var _confirmpasswordObscure = true.obs;
  var _isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          'change_app_password'.tr.toUpperCase(),
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _passwordController,
                keyboardType: const TextInputType.numberWithOptions(),
                obscureText: _passwordObscure.value,
                maxLength: 6,
                cursorColor: secondaryColor,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'change_password_validate'.tr;
                  }
                },
                decoration: InputDecoration(
                  label: Text(
                      'change_password_password'.tr),
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 15),
                  floatingLabelStyle:
                      const TextStyle(color: secondaryColor, fontSize: 15),
                  counterText: '',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordObscure.value = !_passwordObscure.value;
                      });
                    },
                    icon: Icon(
                      _passwordObscure.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: TextFormField(
                  controller: _newPasswordController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  obscureText: _newPasswordObscure.value,
                  maxLength: 6,
                  cursorColor: secondaryColor,
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'change_password_validate'.tr;
                    }
                  },
                  decoration: InputDecoration(
                    label:
                        Text('change_password_new'.tr),
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 15),
                    floatingLabelStyle:
                        const TextStyle(color: secondaryColor, fontSize: 15),
                    counterText: '',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _newPasswordObscure.value =
                              !_newPasswordObscure.value;
                        });
                      },
                      icon: Icon(
                        _newPasswordObscure.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: _confirmNewPasswordController,
                keyboardType: const TextInputType.numberWithOptions(),
                obscureText: _confirmpasswordObscure.value,
                maxLength: 6,
                cursorColor: secondaryColor,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'change_password_validate'.tr;
                  } else if (value != _newPasswordController.text) {
                    return 'change_password_not_equal'.tr;
                  }
                },
                decoration: InputDecoration(
                  label: Text('change_password_new_confirm'.tr),
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 15),
                  floatingLabelStyle:
                      const TextStyle(color: secondaryColor, fontSize: 15),
                  counterText: '',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _confirmpasswordObscure.value =
                            !_confirmpasswordObscure.value;
                      });
                    },
                    icon: Icon(
                      _confirmpasswordObscure.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _isLoading.value == false
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () => _changePassword(
                      _passwordController.text, _newPasswordController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'confirm'.tr.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          : const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              ),
            ),
    );
  }

  _changePassword(String password, String confirm) async {
    if (_formKey.currentState!.validate()) {
      try {
        _isLoading(true);
        await changePassword(password, confirm).then((value) {
          if (value['success'] == true) {
            Get.snackbar('message'.tr,
                'change_password_changed'.tr);

            Get.back();
          }
        });
      } catch (e) {
        throw Exception(e.toString());
      } finally {
        _isLoading(false);
      }
    } else {
      return;
    }
  }
}
