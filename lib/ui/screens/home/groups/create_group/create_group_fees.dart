import 'package:app_flutter_miban4/data/api/groups/createGroupMutualParams.dart';
import 'package:app_flutter_miban4/data/api/home/params.dart';
import 'package:app_flutter_miban4/data/model/params/params.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/create_group/create_group_params.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/create_group/group_add_members.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class GroupFees extends StatefulWidget {
  final String membership;
  final String members;

  const GroupFees({super.key, required this.membership, required this.members});

  @override
  State<GroupFees> createState() => _GroupFeesState();
}

class _GroupFeesState extends State<GroupFees> {
  late Params? params;

  String _selectedFees = '';

  String _selectedContrib = '';

  String _selectPriority = '';
  String _selectedPriorityValue = '';

  String _selectedMora = '';

  String _selectedCharge = '';
  bool _chargeSelected = false;

  late String lang;

  var isLoading = false.obs;

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
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');

    List<DropdownMenuItem<String>> interest = params!.mutualFee.map((interest) {
      return DropdownMenuItem<String>(
          value: interest.value,
          child: Text(
              '${currencyFormat.format(double.parse(interest.value) / 100)} %'));
    }).toList();

    List<DropdownMenuItem<String>> installmentQuantity =
        params!.mutualInstallments.map((installment) {
      return DropdownMenuItem<String>(
          value: installment.value, child: Text(installment.value));
    }).toList();

    List<DropdownMenuItem<String>> priorities =
        params!.mutualPriorities.map((priority) {
      return DropdownMenuItem<String>(
          value: priority.value, child: Text(AppLocalizations.of(context)!.codeLang == 'pt' ? priority.label : priority.value));
    }).toList();

    return Scaffold(
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.group_new,
        backPage: () => Get.off(
          () => GroupParams(membership: widget.membership),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.group_credit_data,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: DropdownButtonFormField<String>(
                value: _selectedFees.isEmpty ? null : _selectedFees,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                elevation: 16,
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.group_interest,
                  // Add label text here
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 16),
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
                    _selectedFees = newValue!;
                  });
                },
                items: interest,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: DropdownButtonFormField<String>(
                value: _selectedContrib.isEmpty ? null : _selectedContrib,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                elevation: 16,
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.group_installments,
                  // Add label text here
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 16),
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
                items: installmentQuantity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: DropdownButtonFormField<String>(
                value: _selectPriority.isEmpty ? null : _selectPriority,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                elevation: 16,
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.group_priority,
                  // Add label text here
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 16),
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
                    _selectPriority = newValue!;
                    _selectedPriorityValue = params!.mutualPriorities
                        .firstWhere((priority) => priority.value == newValue)
                        .value;
                  });
                },
                items: priorities,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: DropdownButtonFormField<String>(
                value: _selectedMora.isEmpty ? null : _selectedMora,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                elevation: 16,
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.group_late_fees,
                  // Add label text here
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 16),
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
                items: <String>[
                  '2,0%',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: DropdownButtonFormField<String>(
                value: _selectedCharge.isEmpty ? null : _selectedCharge,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                elevation: 16,
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.group_billing,
                  // Add label text here
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 16),
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
                  _selectedCharge == AppLocalizations.of(context)!.yes
                      ? _chargeSelected = true
                      : _chargeSelected = false;
                  setState(() {
                    _selectedCharge = newValue!;
                  });
                },
                items: <String>[
                  AppLocalizations.of(context)!.yes,
                  AppLocalizations.of(context)!.no,
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const Spacer(),
            Obx(() => isLoading.value == false
                ? SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedFees.isNotEmpty &&
                            _selectedContrib.isNotEmpty &&
                            _selectPriority.isNotEmpty &&
                            _selectedCharge.isNotEmpty) {
                          _createMutualParams(int.parse(_selectedFees),
                              _selectedContrib, _selectPriority);
                        } else {
                          null;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedFees.isNotEmpty &&
                                _selectedContrib.isNotEmpty &&
                                _selectPriority.isNotEmpty &&
                                _selectedCharge.isNotEmpty
                            ? secondaryColor
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.proceed.toUpperCase(),
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
          ],
        ),
      ),
    );
  }

  _createMutualParams(int amount, String installment, String priority) async {
    String userID = await SharedPreferencesFunctions.getString(key: 'userID');
    setState(() {
      isLoading(true);
    });
    try {
      await createMutualParams(
              amount, installment, _selectedPriorityValue, _chargeSelected)
          .then((response) {
        if (response is Map &&
            response.containsKey('group_account_id') &&
            response['group_account_id'] != null) {
          setState(() {
            isLoading(false);
          });
          Get.to(() => AddGroupMembers(
                membership: widget.membership,
                members: widget.members,
                userID: userID,
              ));
        } else {
          setState(() {
            isLoading(false);
          });
        }
      });
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      setState(() {
        isLoading(false);
      });
    }
  }
}
