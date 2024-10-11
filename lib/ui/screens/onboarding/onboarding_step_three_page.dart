import 'package:app_flutter_miban4/data/api/onboarding/cep.dart';
import 'package:app_flutter_miban4/data/model/onboarding/get_cep.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/data/util/helpers/validators.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/onboarding/step_four_controller.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_two_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class OnboardingStepThreePage extends StatefulWidget {
  const OnboardingStepThreePage({super.key});

  @override
  State<OnboardingStepThreePage> createState() => _OnboardingStepThreePageState();
}

class _OnboardingStepThreePageState extends State<OnboardingStepThreePage> with ValidationsMixin {
  final _formKey = GlobalKey<FormState>();
  bool check = false;
  final TextEditingController _cep = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _complement = TextEditingController();
  final TextEditingController _neighborhood = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final StepFourController _stepFourController = Get.put(StepFourController());
  late String lang;

  String _selectedResidentialType = '';
  String _selectedState = '';
  String id = '';

  final List<String> _residencialState = [
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _cep.dispose();
    _address.dispose();
    _number.dispose();
    _complement.dispose();
    _neighborhood.dispose();
    _city.dispose();
    _state.dispose();
    _stepFourController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    lang = AppLocalizations.of(context)!.codeLang;

    final List<String> residencialType = [
      AppLocalizations.of(context)!.address_type_own,
      AppLocalizations.of(context)!.address_type_rent,
      AppLocalizations.of(context)!.address_type_financed,
      AppLocalizations.of(context)!.address_type_company,
      AppLocalizations.of(context)!.address_type_parents
    ];

    final List<String> residentialTypeEn = [
      "Own",
      "Rent"
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: SafeArea(
          child: IconButton(
            onPressed: () {
              Get.to(() => const OnboardingStepTwoPage(),
                  transition: Transition.leftToRight);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  AppLocalizations.of(context)!.full_address_information,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        cursorColor: secondaryColor,
                        onChanged: _changeCep,
                        controller: _cep,
                        keyboardType: const TextInputType.numberWithOptions(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        validator: isNotEmpty,
                        inputFormatters: [cepMaskFormatter],
                        maxLength: 9,
                        decoration: InputDecoration(
                          counterText: "",
                          isDense: true,
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
                          labelText: AppLocalizations.of(context)!.address_cep,
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
                      child: DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        hint: Text(AppLocalizations.of(context)!.address_type),
                        key: UniqueKey(),
                        value: _selectedResidentialType.isEmpty
                            ? null
                            : _selectedResidentialType,
                        items: lang == 'pt' ? residencialType
                            .map<DropdownMenuItem<String>>((String item) {
                          return DropdownMenuItem<String>(
                              value: item, child: Text(item));
                        }).toList() : residentialTypeEn
                            .map<DropdownMenuItem<String>>((String item) {
                          return DropdownMenuItem<String>(
                              value: item, child: Text(item));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedResidentialType = newValue!;
                            isNotEmpty;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        cursorColor: secondaryColor,
                        controller: _address,
                        keyboardType: TextInputType.streetAddress,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        validator: (value) => combineValidators([
                              () => isNotEmpty(value),
                        ]),
                        decoration: InputDecoration(
                          isDense: true,
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
                          labelText: AppLocalizations.of(context)!.address,
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
                        controller: _number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')),
                        ],
                        keyboardType: const TextInputType.numberWithOptions(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                          isDense: true,
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
                          labelText:
                              AppLocalizations.of(context)!.address_number,
                          labelStyle: const TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          ),
                          hintText: '',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            activeColor: secondaryColor,
                            value: check,
                            onChanged: (newValue) {
                              setState(() {
                                check = newValue!;
                                _number.clear();
                              });
                            }),
                        Text(
                          AppLocalizations.of(context)!.address_no_number,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        cursorColor: secondaryColor,
                        controller: _complement,
                        keyboardType: TextInputType.text,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9\sS]')),
                        ],
                        decoration: InputDecoration(
                          isDense: true,
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
                          labelText:
                              AppLocalizations.of(context)!.address_complement,
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
                        controller: _neighborhood,
                        keyboardType: TextInputType.text,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        validator: isNotEmpty,
                        decoration: InputDecoration(
                          isDense: true,
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
                          labelText: AppLocalizations.of(context)!
                              .address_neighborhood,
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
                      child: DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        hint: Text(AppLocalizations.of(context)!.address_state),
                        key: UniqueKey(),
                        value: _selectedState.isEmpty ? null : _selectedState,
                        items: _residencialState
                            .map<DropdownMenuItem<String>>((String item) {
                          return DropdownMenuItem<String>(
                              value: item, child: Text(item));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedState =
                                newValue ?? _residencialState.first;
                            isNotEmpty;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        cursorColor: secondaryColor,
                        controller: _city,
                        keyboardType: TextInputType.text,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        validator: isNotEmpty,
                        decoration: InputDecoration(
                          isDense: true,
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
                          labelText: AppLocalizations.of(context)!.address_city,
                          labelStyle: const TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          ),
                          hintText: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Obx(
                  () => _stepFourController.isLoading.value == false
                      ? ElevatedButton(
                          onPressed: _stepFour,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  _stepFour() async {
    if (_formKey.currentState!.validate()) {
      String postalCode = _cep.text.replaceAll("-", "").toString();
      String type = lang == 'pt'
          ? mapResidentialTypeToStringPt(_selectedResidentialType)
          : mapResidentialTypeToStringUs(_selectedResidentialType);
      String street = _address.text.toString();
      String number = _number.text.toString();
      String complement = _complement.text.toString();
      String neighborhood = _neighborhood.text.toString();
      String state = _selectedState.toString();
      String city = _city.text.toString();
      String country = "Brasil";

      try {
        await _stepFourController.stepFour(postalCode, type, street, number,
            neighborhood, complement, state, city, country);
      } catch (error) {
        throw Exception(error);
      }
    }
  }

  String mapResidentialTypeToStringPt(String type) {
    switch (type) {
      case 'Próprio':
        return '1';
      case 'Alugado':
        return '2';
      case 'Financiado':
        return '3';
      case 'Empresa':
        return '4';
      case 'com os Pais':
        return '5';
      default:
        return '';
    }
  }

  String mapResidentialTypeToStringUs(String type) {
    switch (type) {
      case 'Own':
        return '1';
      case 'Rent':
        return '2';
      case 'Financed':
        return '3';
      case 'Company':
        return '4';
      case 'with parents':
        return '5';
      default:
        return '';
    }
  }

  _changeCep(String cepValue) async {
    cepValue = _cep.text.replaceAll('-', "");

    setState(() async {
      if (_cep.text.length > 8) {
        CepModel cep = await getCep(cepValue);
        _city.text = cep.localidade;
        _neighborhood.text = cep.bairro;
        _address.text = cep.logradouro;

        if (_residencialState.contains(cep.uf)) {
          _selectedState = cep.uf;
          _state.text = _selectedState.toString();
        } else {
          _selectedState = '';
        }
      }
    });
  }
}
