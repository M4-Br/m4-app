import 'package:app_flutter_miban4/data/api/groups/createGroupParams.dart';
import 'package:app_flutter_miban4/data/api/home/params.dart';
import 'package:app_flutter_miban4/data/model/params/params.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/create_group/create_group_fees.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/create_group/create_group_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroupParams extends StatefulWidget {
  final String membership;

  const GroupParams({super.key, required this.membership});

  @override
  State<GroupParams> createState() => _GroupParamsState();
}

class _GroupParamsState extends State<GroupParams> {
  late Params? params;

  String _selectedPeriod = '';
  String _selectedPeriodValue = '';

  String _selectValuePeriod = '';
  String _selectedValuePeriodValue = '';

  String _selectedContrib = '';

  String _selectedMember = '';

  var isLoading = false.obs;
  late String lang;

  _getLang() async {
    lang = await SharedPreferencesFunctions.getString(key: 'codeLang');
  }

  @override
  void initState() {
    super.initState();
    params = getGlobalParams();
    _getLang();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '\$');
    final String language = 'codeLang'.tr;

    List<DropdownMenuItem<String>> periodsItems = params!.periods.map((period) {
      return DropdownMenuItem<String>(
          value: period.value,
          child: Text(language == 'pt' ? period.label : period.value));
    }).toList();

    List<DropdownMenuItem<String>> periodValueItems =
        params!.amountByPeriods.map((amount) {
      return DropdownMenuItem<String>(
          value: amount.value,
          child: Text(currencyFormat.format(double.parse(amount.value) / 100)));
    }).toList();

    List<DropdownMenuItem<String>> contributions =
        params!.installments.map((contri) {
      return DropdownMenuItem<String>(
        value: contri.value,
        child: Text(contri.value),
      );
    }).toList();

    List<DropdownMenuItem<String>> members =
        params!.quantityOfMembers.map((members) {
      return DropdownMenuItem<String>(
          value: members.value, child: Text(members.value));
    }).toList();

    return Scaffold(
      appBar: AppBarDefault(
        title: 'group_new'.tr,
        backPage: () => Get.off(() => const CreateGroupName(),
            transition: Transition.leftToRight),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'group_economy_data'.tr,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: DropdownButtonFormField<String>(
                          value:
                              _selectedPeriod.isEmpty ? null : _selectedPeriod,
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          elevation: 16,
                          isExpanded: true,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          decoration: InputDecoration(
                            labelText: 'group_period'.tr,
                            // Add label text here
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            border: InputBorder.none,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedPeriod = newValue!;
                              _selectedPeriodValue = params!.periods
                                  .firstWhere(
                                      (period) => period.value == newValue)
                                  .value;
                            });
                          },
                          items: periodsItems,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: DropdownButtonFormField<String>(
                          value: _selectValuePeriod.isEmpty
                              ? null
                              : _selectValuePeriod,
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          elevation: 16,
                          isExpanded: true,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          decoration: InputDecoration(
                            labelText: 'group_period_value'.tr,
                            // Add label text here
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            border: InputBorder.none,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectValuePeriod = newValue!;
                              _selectedValuePeriodValue = params!
                                  .amountByPeriods
                                  .firstWhere(
                                      (amount) => amount.value == newValue)
                                  .value;
                            });
                          },
                          items: periodValueItems,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: DropdownButtonFormField<String>(
                          value: _selectedContrib.isEmpty
                              ? null
                              : _selectedContrib,
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          elevation: 16,
                          isExpanded: true,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          decoration: InputDecoration(
                            labelText: 'group_contributions_quantity'.tr,
                            // Add label text here
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            border: InputBorder.none,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedContrib = newValue!;
                            });
                          },
                          items: contributions,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: DropdownButtonFormField<String>(
                          value:
                              _selectedMember.isEmpty ? null : _selectedMember,
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          elevation: 16,
                          isExpanded: true,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          decoration: InputDecoration(
                            labelText: 'group_members_quantity'.tr,
                            // Add label text here
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            border: InputBorder.none,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedMember = newValue!;
                            });
                          },
                          items: members,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
              child: Container(
                decoration: const BoxDecoration(
                  color: grey120,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  '\$',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                ),
                                Text(
                                  _selectedContrib.isNotEmpty
                                      ? '$_selectedContrib x ${'off'.tr}'
                                      : '0x of',
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            _selectValuePeriod.isNotEmpty
                                ? currencyFormat
                                    .format(double.parse(
                                            _selectedValuePeriodValue) /
                                        100)
                                    .replaceAll('\$', "")
                                : "0,00",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: '${'group_value_per_member'.tr}: '),
                            TextSpan(
                              text: _selectValuePeriod.isNotEmpty &&
                                      _selectedContrib.isNotEmpty
                                  ? currencyFormat.format((double.parse(
                                              _selectValuePeriod
                                                  .replaceAll('R\$', '')
                                                  .replaceAll(',', '')) *
                                          int.parse(_selectedContrib)) /
                                      100)
                                  : '0,00',
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Obx(() => isLoading.value == false
                            ? SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_selectedPeriod.isNotEmpty &&
                                        _selectValuePeriod.isNotEmpty &&
                                        _selectedContrib.isNotEmpty &&
                                        _selectedMember.isNotEmpty) {
                                      _setParams(
                                        int.parse(_selectedValuePeriodValue),
                                        int.parse(_selectedContrib),
                                        int.parse(_selectedMember),
                                        _selectedPeriodValue,
                                      );
                                    } else {
                                      null;
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      backgroundColor: _selectedPeriod
                                                  .isNotEmpty &&
                                              _selectValuePeriod.isNotEmpty &&
                                              _selectedContrib.isNotEmpty &&
                                              _selectedMember.isNotEmpty
                                          ? secondaryColor
                                          : Colors.grey),
                                  child: Text(
                                    'proceed'.tr.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: secondaryColor,
                                ),
                              )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _setParams(
    int amount,
    int installment,
    int members,
    String period,
  ) async {
    setState(() {
      isLoading(true);
    });
    try {
      await SharedPreferencesFunctions.saveString(
          key: 'period', value: _selectedPeriod);
      await SharedPreferencesFunctions.saveString(
          key: 'installment', value: _selectedContrib);
      await SharedPreferencesFunctions.saveString(
          key: 'amount', value: _selectedValuePeriodValue.replaceAll('\$', ''));
      await creatGroupParams(amount, installment, members, period)
          .then((response) {
        if (response.containsKey('id') && response['id'] != null) {
          isLoading(false);
          Get.to(
              () => GroupFees(
                    membership: widget.membership,
                    members: _selectedMember,
                  ),
              transition: Transition.rightToLeft);
        } else {
          isLoading(false);
        }
      });
    } catch (e) {
      setState(() {
        isLoading(false);
      });
      throw Exception(e.toString());
    } finally {
      setState(() {
        isLoading(false);
      });
    }
  }
}
