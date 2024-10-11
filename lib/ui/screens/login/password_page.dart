import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/data/util/helpers/validators.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/login/login_controller.dart';
import 'package:app_flutter_miban4/ui/screens/login/code_validate/code_validate_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class PasswordPage extends StatefulWidget {
  final String? document;

  const PasswordPage({super.key, this.document});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> with ValidationsMixin {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String document = '';
  final TextEditingController _passwordController = TextEditingController();
  final LoginController _loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    _codeLang();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32, left: 32),
              child: SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 50),
              child: SizedBox(
                width: 200,
                child: Image.asset('assets/images/ic_default_logo.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 55, 32, 50),
              child: TextFormField(
                cursorColor: Colors.white,
                validator: (value) => combineValidators(
                    [() => isNotEmpty(value), () => hasSixChars(value)]),
                controller: _passwordController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                obscureText: _obscureText,
                maxLength: 6,
                decoration: InputDecoration(
                  counterText: "",
                  isDense: true,
                  border: InputBorder.none,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  contentPadding: EdgeInsets.zero,
                  labelText: AppLocalizations.of(context)!.password,
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  hintText: '',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 30, 32, 50),
              child: Obx(
                () => _loginController.isLoading.value == false
                    ? ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side:
                                const BorderSide(color: Colors.white, width: 2),
                          ),
                          alignment: Alignment.center,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.access,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      )
                    : const CircularProgressIndicator(
                        color: Colors.white,
                      ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () => Get.to(() => const CodeValidatePage(page: 0),
                  transition: Transition.rightToLeft),
              child: Container(
                width: double.infinity,
                color: thirdColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    AppLocalizations.of(context)!.forgot_password,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      String password = _passwordController.text;

      try {
        await _loginController.login(widget.document!, password);
      } catch (error) {
        throw Exception(error);
      }
    }
  }

  _codeLang() async {
    await SharedPreferencesFunctions.saveString(
        key: 'codeLang', value: AppLocalizations.of(context)!.codeLang);
  }
}
