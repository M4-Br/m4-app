import 'package:app_flutter_miban4/core/config/auth/controller/user_controller.dart';
import 'package:app_flutter_miban4/core/config/auth/model/user.dart';
import 'package:app_flutter_miban4/data/api/pix/pixKeys.dart';
import 'package:app_flutter_miban4/data/model/pix/pixKeys.dart';
import 'package:app_flutter_miban4/data/model/userData/user.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/pix/create_pixKey_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixKeyManager.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixMyKeys.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixNewKey.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixAddKeys extends StatefulWidget {
  const PixAddKeys({Key? key}) : super(key: key);

  @override
  State<PixAddKeys> createState() => _PixAddKeysState();
}

class _PixAddKeysState extends State<PixAddKeys> {
  PixKeys? keys;
  bool _isSelected = false;
  String _typeSelected = '';
  String _key = '';
  var _obscureText = true.obs;
  String dropdownValue = '';

  final UserController _userController = Get.put(UserController());
  final CreateKeyController _keyController = Get.put(CreateKeyController());
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPixKeys().then((pixKeys) {
      setState(() {
        keys = pixKeys;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dropdownValue = 'pix_choose_new'.tr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: 'pix_registerNewKey'.tr,
        backPage: () => Get.off(() => const PixKeyManager(),
            transition: Transition.leftToRight),
      ),
      body: Obx(() {
        User? userData = _userController.user.value;

        return Container(
          width: MediaQuery.of(context).size.width,
          color: const Color(0xFFe9eaf0),
          padding: const EdgeInsets.all(16.0),
          child: keys == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'pix_registerKey_inform'.tr,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        isExpanded: true,
                        underline: Container(
                          height: 1,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black54))),
                        ),
                        onChanged: (String? newValue) {
                          if (newValue != null &&
                              newValue != 'pix_choose_new'.tr) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          }
                        },
                        items: <String>[
                          'pix_choose_new'.tr,
                          'pix_randomKeyRegister'.tr,
                          'CPF / CNPJ',
                          'pix_phone'.tr,
                          'Email',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    if (dropdownValue == 'CPF / CNPJ')
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isSelected = !_isSelected;
                            _typeSelected = 'document';
                            _key = userData!.payload.document;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 80,
                          padding: const EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade300,
                            border: _isSelected
                                ? Border.all(color: secondaryColor, width: 2)
                                : Border.all(color: Colors.transparent),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/ic_pix_person.png',
                                  width: 20,
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    MaskUtil.applyMask(
                                        userData!.payload.document,
                                        "###.###.###-##"),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (dropdownValue == 'pix_phone'.tr)
                      InkWell(
                        onTap: () {
                          Get.to(
                              () => PixNewKey(
                                    pixKey: 'phone',
                                  ),
                              transition: Transition.rightToLeft);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 80,
                          padding: const EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade300,
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/ic_add_content.png',
                                  width: 30,
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    'pix_anotherNumber'.tr,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (dropdownValue == 'Email')
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(
                                  () => PixNewKey(
                                        pixKey: 'email',
                                      ),
                                  transition: Transition.rightToLeft);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 80,
                              padding: const EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300,
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/ic_add_content.png',
                                      width: 30,
                                      color: Colors.black,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text(
                                        'pix_anotherEmail'.tr,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isSelected = !_isSelected;
                                _typeSelected = 'email';
                                _key = userData!.payload.email;
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: 80,
                              padding: const EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300,
                                border: _isSelected
                                    ? Border.all(
                                        color: secondaryColor, width: 2)
                                    : Border.all(color: Colors.transparent),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/ic_pix_email.png',
                                      width: 30,
                                      color: Colors.black,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text(
                                        userData!.payload.email,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (dropdownValue == 'pix_randomKeyRegister'.tr)
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isSelected = !_isSelected;
                            _typeSelected = 'evp';
                            _key = '';
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 80,
                          padding: const EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade300,
                            border: _isSelected
                                ? Border.all(color: secondaryColor, width: 2)
                                : Border.all(color: Colors.transparent),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/ic_pix_random_key.png',
                                  width: 30,
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    'pix_randomKeyRegister'.tr,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () => Get.to(() => const PixMyKeys(),
                                  transition: Transition.leftToRight),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade400,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              child: Text(
                                'cancel'.tr.toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () => _isSelected
                                  ? showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog.adaptive(
                                          title: Text(
                                            'password_insert'.tr,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Container(
                                            height: 200,
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              children: [
                                                Obx(
                                                  () => TextField(
                                                    controller:
                                                        _passwordController,
                                                    cursorColor: secondaryColor,
                                                    keyboardType:
                                                        const TextInputType
                                                            .numberWithOptions(),
                                                    obscureText:
                                                        _obscureText.value,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black),
                                                    maxLength: 6,
                                                    decoration: InputDecoration(
                                                      counterText: "",
                                                      isDense: true,
                                                      border: InputBorder.none,
                                                      enabledBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                      ),
                                                      focusedBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                secondaryColor),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      hintText: '',
                                                      suffixIcon: Obx(
                                                        () => IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _obscureText
                                                                      .value =
                                                                  !_obscureText
                                                                      .value;
                                                            });
                                                          },
                                                          icon: Icon(
                                                            _obscureText.value ==
                                                                    true
                                                                ? Icons
                                                                    .visibility_off
                                                                : Icons
                                                                    .visibility,
                                                            color:
                                                                secondaryColor,
                                                            size: 25,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 16),
                                                  child: SizedBox(
                                                    height: 40,
                                                    width: double.infinity,
                                                    child: Obx(
                                                      () =>
                                                          _keyController
                                                                      .isLoading
                                                                      .value ==
                                                                  false
                                                              ? ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    _keyController.createPixKey(
                                                                        userData!
                                                                            .payload
                                                                            .document,
                                                                        _passwordController
                                                                            .text
                                                                            .toString(),
                                                                        _key,
                                                                        _typeSelected);
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        secondaryColor,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                    'confirm'
                                                                        .tr
                                                                        .toUpperCase(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                )
                                                              : const Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color:
                                                                        secondaryColor,
                                                                  ),
                                                                ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 16),
                                                  child: SizedBox(
                                                    height: 40,
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            grey120,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'cancel'
                                                            .tr
                                                            .toUpperCase(),
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                                  : null,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: _isSelected
                                      ? secondaryColor
                                      : Colors.grey.shade400,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              child: Text(
                                'register_button'.tr.toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
        );
      }),
    );
  }
}
