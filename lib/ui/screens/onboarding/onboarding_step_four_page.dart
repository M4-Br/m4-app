import 'package:app_flutter_miban4/data/api/onboarding/professions_list.dart';
import 'package:app_flutter_miban4/data/model/onboarding/get_profession.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/data/util/helpers/validators.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/onboarding/step_five_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class OnboardingStepFourPage extends StatefulWidget {
  const OnboardingStepFourPage({super.key});

  @override
  State<OnboardingStepFourPage> createState() => _OnboardingStepFourPageState();
}

class _OnboardingStepFourPageState extends State<OnboardingStepFourPage> with ValidationsMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _income = TextEditingController();
  final TextEditingController _profession = TextEditingController();
  final TextEditingController _incomeDialog =
      TextEditingController(text: '0,00');
  final StepFiveController _stepFiveController = Get.put(StepFiveController());

  String selectedProfession = "";
  late int selectedId;
  String id = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _income.dispose();
    _profession.dispose();
    _incomeDialog.dispose();
    _stepFiveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.income_inform,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black54),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextField(
                readOnly: true,
                onTap: () async {
                  List<Professions> professionsList = await getProfessions();
                  _showProfessionsDialog(professionsList);
                },
                onChanged: (String value) {
                  setState(() {
                    selectedProfession = value;
                  });
                },
                controller: _profession,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor),
                  ),
                  contentPadding: EdgeInsets.zero,
                  labelText: AppLocalizations.of(context)!.profession,
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  labelStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                  hintText: "",
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  cursorColor: secondaryColor,
                  controller: _income,
                  keyboardType: const TextInputType.numberWithOptions(),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      final text =
                          MaskUtil.applyMask(newValue.text, '###.###,##');
                      _income.value = _income.value.copyWith(
                        text: text,
                        selection: TextSelection.collapsed(offset: text.length),
                      );
                      return _income.value;
                    }),
                  ],
                  style: const TextStyle(color: Colors.black, fontSize: 20),
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
                    contentPadding: EdgeInsets.zero,
                    labelText: AppLocalizations.of(context)!.income,
                    labelStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                    hintText: '',
                  ),
                ),
              ),
            ),
            const Spacer(),
            Obx(
              () => _stepFiveController.isLoading.value == false
                  ? ElevatedButton(
                      onPressed: _stepFive,
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
          ],
        ),
      ),
    );
  }

  void _showProfessionsDialog(List<Professions> professionsList) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(AppLocalizations.of(context)!.choose_profession),
          content: Container(
            color: Colors.white,
            width: double.maxFinite,
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: professionsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(professionsList[index].description),
                    onTap: () {
                      setState(() {
                        selectedProfession = professionsList[index].description;
                        selectedId = professionsList[index].id;
                        _profession.text = selectedProfession;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
                separatorBuilder: (_, index) => const Divider(
                      color: Colors.black87,
                    )),
          ),
        );
      },
    );
  }

  _stepFive() async {
    if (_formKey.currentState!.validate()) {
      String professionId = selectedId.toString();
      int income =
          int.parse(_income.text.replaceAll(".", "").replaceAll(",", ""));

      try {
        await _stepFiveController.stepFive(professionId, income);
      } catch (error) {
        throw Exception(error);
      }
    }
  }
}
