import 'package:app_flutter_miban4/data/api/groups/createGroup.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/create_group/create_group_params.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateGroupName extends StatefulWidget {
  const CreateGroupName({super.key});

  @override
  State<CreateGroupName> createState() => _CreateGroupNameState();
}

class _CreateGroupNameState extends State<CreateGroupName> {
  final TextEditingController _groupName = TextEditingController();
  final TextEditingController _initialDate = TextEditingController();
  String _selectedValue = '';
  var isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);
    _initialDate.text = formattedDate;

    return Scaffold(
      appBar: AppBarDefault(
        title: 'group_new'.tr,
        backPage: () => Get.off(() => const GroupsScreen(),
            transition: Transition.leftToRight),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
             'group_data'.tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextField(
                controller: _groupName,
                cursorColor: primaryColor,
                maxLength: 20,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  isDense: true,
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
                  contentPadding: EdgeInsets.zero,
                  labelText: 'group_new_name'.tr,
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  hintText: '',
                  counter: Container(
                    padding: const EdgeInsets.only(top: 10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${20 - _groupName.text.length} ${'available_char'.tr}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextField(
                controller: _initialDate,
                cursorColor: primaryColor,
                readOnly: true,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  isDense: true,
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
                  contentPadding: EdgeInsets.zero,
                  labelText: 'group_initial_date'.tr,
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  hintText: '',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: DropdownButtonFormField<String>(
                value: _selectedValue.isEmpty ? "" : _selectedValue,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                elevation: 16,
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'group_member'.tr,
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
                    _selectedValue = newValue!;
                  });
                },
                items: <String>[
                  "",
                  'yes'.tr,
                  'no'.tr
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
                      onPressed: () async {
                        _groupName.text.isNotEmpty &&
                                    _selectedValue ==
                                       'yes'.tr ||
                                _groupName.text.isNotEmpty &&
                                    _selectedValue ==
                                        'no'.tr
                            ? _verifyGroup(
                                _groupName.text.toString(),
                                _selectedValue ==
                                        'yes'.tr
                                    ? true
                                    : false)
                            : null;
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          backgroundColor: _groupName.text.isNotEmpty &&
                                      _selectedValue ==
                                          'yes'.tr ||
                                  _groupName.text.isNotEmpty &&
                                      _selectedValue ==
                                          'no'.tr
                              ? secondaryColor
                              : Colors.grey),
                      child: Text(
                        'proceed'.tr,
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

  _verifyGroup(String name, bool membership) async {
    setState(() {
      isLoading(true);
    });
    _groupName.text.isNotEmpty && _selectedValue.isNotEmpty
        ? _createGroup(name, membership)
        : null;
  }

  _createGroup(String name, bool membership) async {
    await createGroup(name, membership).then((response) {
      if (response['name'].toString().isNotEmpty) {
        setState(() {
          isLoading(false);
        });
        Get.to(
            () => GroupParams(
                  membership: _selectedValue,
                ),
            transition: Transition.rightToLeft);
      } else {
        setState(() {
          isLoading(false);
        });
      }
    });
  }
}
