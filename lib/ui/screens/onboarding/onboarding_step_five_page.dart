import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/data/util/helpers/validators.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/onBoarding/commom_textfield.dart';
import 'package:app_flutter_miban4/ui/controllers/onboarding/step_six_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OnboardingStepFivePage extends StatefulWidget {
  const OnboardingStepFivePage({super.key});

  @override
  State<OnboardingStepFivePage> createState() => _OnboardingStepFivePageState();
}

class _OnboardingStepFivePageState extends State<OnboardingStepFivePage> with ValidationsMixin {
  bool check = false;
  String id = '';
  bool _isPep = false;
  bool _pepFinal = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _motherName = TextEditingController();
  final TextEditingController _birth = TextEditingController();
  final TextEditingController _rg = TextEditingController();
  final TextEditingController _rgIssuer = TextEditingController();
  final TextEditingController _rgDate = TextEditingController();
  final TextEditingController _pepDate = TextEditingController();
  final StepSixController _stepSixController = Get.put(StepSixController());

  String selectedGender = "";

  String selectedMaritalStatus = "";

  String selectedNacionality = "";

  List<String> residencialState = [
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'
  ];
  String _selectedResidencialState = "";

  String _selectedPep = "";

  String lang = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _motherName.dispose();
    _birth.dispose();
    _rg.dispose();
    _rgIssuer.dispose();
    _rgDate.dispose();
    _pepDate.dispose();
    _stepSixController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    lang = 'codeLang'.tr;

    List<String> gender = [
      'gender_male'.tr,
      'gender_female'.tr,
      'gender_another'.tr,
      'gender_notDefined'.tr
    ];

    List<String> maritalStatus = [
      'marital_status_single'.tr,
      'marital_status_married'.tr,
      'marital_status_legally_separated'.tr,
      'marital_status_widowed'.tr,
      'marital_status_cohabitant'.tr,
      'marital_status_separated'.tr
    ];

    List<String> maritalStatusEn = ["Single", "Married"];

    List<String> nationality = [
      'nationality_brazilian'.tr,
      'nationality_foreigner'.tr
    ];

    List<String> pep = [
      'pep_no'.tr,
      'pep_yes'.tr
    ];

    return Scaffold(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'personal_data'.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Text(
                    'pay_attention'.tr,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: _name,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    validator: (value) => combineValidators([
                      () => isNotEmpty(value),
                      () => validateChar(value),
                    ]),
                    decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      contentPadding: EdgeInsets.zero,
                      labelText: 'document_name'.tr,
                      labelStyle: const TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                      hintText: '',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    cursorColor: secondaryColor,
                    controller: _motherName,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    validator: (value) => combineValidators([
                      () => isNotEmpty(value),
                      () => validateChar(value),
                    ]),
                    decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      contentPadding: EdgeInsets.zero,
                      labelText:
                          'document_mother_name'.tr,
                      labelStyle: const TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                      hintText: '',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    hint: Text('document_gender'.tr),
                    value: selectedGender.isEmpty ? null : selectedGender,
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black54)),
                      ),
                    ),
                    items: gender.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    cursorColor: secondaryColor,
                    controller: _birth,
                    keyboardType: TextInputType.datetime,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    validator: (value) => combineValidators([
                      () => validateDate(value),
                    ]),
                    inputFormatters: [birthMaskFormatter],
                    maxLength: 10,
                    decoration: InputDecoration(
                      counterText: "",
                      isDense: true,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      contentPadding: EdgeInsets.zero,
                      labelText:
                          'document_birthday'.tr,
                      labelStyle: const TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    hint: Text(
                        'document_marital_status'.tr),
                    value: selectedMaritalStatus.isEmpty
                        ? null
                        : selectedMaritalStatus,
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black54)),
                      ),
                    ),
                    items: lang == 'pt'
                        ? maritalStatus
                            .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()
                        : maritalStatusEn
                            .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMaritalStatus = newValue!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    hint: Text(
                        'document_nationality'.tr),
                    value: selectedNacionality.isEmpty
                        ? null
                        : selectedNacionality,
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black54)),
                      ),
                    ),
                    items: nationality
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedNacionality = newValue!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    cursorColor: secondaryColor,
                    controller: _rg,
                    keyboardType: const TextInputType.numberWithOptions(),
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    validator: isNotEmpty,
                    inputFormatters: [rgMaskFormatter],
                    maxLength: 12,
                    decoration: InputDecoration(
                      counterText: "",
                      isDense: true,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      contentPadding: EdgeInsets.zero,
                      labelText: 'document_rg'.tr,
                      labelStyle: const TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                      hintText: '',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    hint: Text('document_state'.tr),
                    value: _selectedResidencialState.isEmpty
                        ? null
                        : _selectedResidencialState,
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black54)),
                      ),
                    ),
                    items: residencialState
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedResidencialState = newValue!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    cursorColor: secondaryColor,
                    controller: _rgIssuer,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    validator: (value) => combineValidators([
                      () => isNotEmpty(value),
                      () => validateChar(value),
                    ]),
                    decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      contentPadding: EdgeInsets.zero,
                      labelText:
                          'document_rgEmission'.tr,
                      labelStyle: const TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                      hintText: '',
                    ),
                  ),
                ),
                commonTextField(
                    _rgDate,
                    'document_rg_date'.tr,
                    TextInputType.datetime,
                    "",
                    birthMaskFormatter, (text) {
                  final brazilianDate = birthMaskFormatter.getUnmaskedText();
                  if (brazilianDate.length == 10) {
                    final parsedDate =
                        DateFormat('dd/MM/yyyy').parse(brazilianDate);
                    final formattedDate =
                        DateFormat('yyyy-MM-dd').format(parsedDate);
                    return formattedDate;
                  }
                  return null;
                }),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Row(
                    children: [
                      Text(
                        'document_pep'.tr,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _pep,
                        child: const Icon(Icons.info_outline_rounded),
                      ),
                    ],
                  ),
                ),
                DropdownButton<String>(
                  dropdownColor: Colors.white,
                  hint: Text('document_pep'.tr),
                  value: _selectedPep.isEmpty
                      ? 'pep_no'.tr
                      : _selectedPep,
                  isExpanded: true,
                  underline: Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black54)),
                    ),
                  ),
                  items: pep.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPep = newValue!;
                      if (_selectedPep ==
                          'pep_yes'.tr) {
                        _isPep = true;
                        _pepFinal = true;
                      } else if (_selectedPep ==
                          'pep_no'.tr) {
                        _isPep = false;
                        _pepFinal = false;
                      }
                    });
                  },
                ),
                Visibility(
                  visible: _isPep,
                  child: commonTextField(
                      _pepDate,
                      'document_pep_date'.tr,
                      TextInputType.datetime,
                      "",
                      birthMaskFormatter, (text) {
                    final brazilianDate = birthMaskFormatter.getUnmaskedText();
                    if (brazilianDate.length == 10) {
                      final parsedDate =
                          DateFormat('dd/MM/yyyy').parse(brazilianDate);
                      final formattedDate =
                          DateFormat('yyyy-MM-dd').format(parsedDate);
                      return formattedDate;
                    }
                    return null;
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Obx(() => _stepSixController.isLoading.value == false
                      ? ElevatedButton(
                          onPressed: _stepSix,
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
                              'next'.tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      : const CircularProgressIndicator(
                          color: secondaryColor,
                        )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pep() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog.adaptive(
            content: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'pep'.tr,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            actions: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      alignment: Alignment.bottomCenter,
                      minimumSize: const Size(150, 40),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  _stepSix() async {
    if (_formKey.currentState!.validate()) {
      String username = _name.text;
      String motherName = _motherName.text;
      String gender = selectedGender.toString();
      String birthDate = _formatDate(_birth.text);
      String maritalStatus = selectedMaritalStatus.toString();
      String nationality = selectedNacionality.toString();
      String documentNumberDot = _rg.text.replaceAll(".", "");
      String documentNumber = documentNumberDot.replaceAll("-", "");
      String documentState = _selectedResidencialState.toString();
      String issuanceDate = _formatDate(_rgDate.text);
      String pepSince = _formatDate(_pepDate.text);
      String firstGenderChar = gender[0];

      try {
        await _stepSixController.stepSix(
            username,
            motherName,
            firstGenderChar,
            birthDate,
            maritalStatus,
            nationality,
            documentNumber,
            documentState,
            issuanceDate,
            _isPep,
            pepSince);
      } catch (error) {
        throw Exception(error);
      }
    }
  }

  String _formatDate(String brazilianDate) {
    if (brazilianDate.length == 10) {
      final parsedDate = DateFormat('dd/MM/yyyy').parse(brazilianDate);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    }
    return brazilianDate;
  }
}
