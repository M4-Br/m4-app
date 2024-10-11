import 'package:app_flutter_miban4/data/api/groups/groupInvite.dart';
import 'package:app_flutter_miban4/data/api/transfer/transferAuth.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/login/user_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/create_group/create_group_fees.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/create_group/group_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mask_shifter_v2/mask_shifter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddGroupMembers extends StatefulWidget {
  final String membership;
  final String members;
  final String userID;

  const AddGroupMembers(
      {super.key,
      required this.membership,
      required this.members,
      required this.userID});

  @override
  State<AddGroupMembers> createState() => _AddGroupMembersState();
}

class _AddGroupMembersState extends State<AddGroupMembers> {
  final TextEditingController _controller = TextEditingController();
  late String memberinvite;
  final UserController _userController = Get.put(UserController());

  var getMember = false.obs;
  var isLoading = false.obs;
  var showSearchResults = false;

  String _name = '';
  String _document = '';
  String _id = '';
  String _maskedDocument = '';

  List<Map<String, dynamic>> users = [];
  int memberCounter = 0;

  @override
  void initState() {
    super.initState();
    widget.membership == 'Sim' || widget.membership == 'Yes'
        ? memberinvite = '1'
        : memberinvite = '0';
    if (widget.membership == 'Sim' || widget.membership == 'Yes') {
      memberCounter++;
      users.add({
        'name': _userController.userData!.value!.payload.fullName,
        'document': _userController.userData.value!.payload.document,
        'id': widget.userID
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_document.length < 13) {
      _maskedDocument = MaskUtil.applyMask(_document, '###.###.###-##');
    } else {
      _maskedDocument = MaskUtil.applyMask(_document, '##.###.###/####-##');
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.group_add_members,
        backPage: () => Get.off(
          () => GroupFees(
            membership: widget.membership,
            members: widget.members,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.group_search_details,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  TextFormField(
                    controller: _controller,
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormatters: [
                      MaskedTextInputFormatterShifter(
                          maskONE: "XXX.XXX.XXX-XX",
                          maskTWO: "XX.XXX.XXX/XXXX-XX")
                    ],
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.group_search,
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: primaryColor,
                          )),
                      suffixIcon: Obx(
                        () => getMember.value == false
                            ? IconButton(
                                onPressed: () => _getUser(_controller.text),
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  color: secondaryColor,
                                ),
                              ),
                      ),
                    ),
                  ),
                  if (showSearchResults)
                    Container(
                      height: 60,
                      color: Colors.grey[200],
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text.rich(TextSpan(children: [
                              TextSpan(
                                  text:
                                      "${AppLocalizations.of(context)!.name}: ",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: _name,
                                  style: const TextStyle(color: Colors.black))
                            ])),
                            subtitle: Text.rich(TextSpan(children: [
                              TextSpan(
                                  text:
                                      "${AppLocalizations.of(context)!.document}: ",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: _maskedDocument,
                                  style: const TextStyle(color: Colors.black))
                            ])),
                            onTap: () {
                              _addUserToList();
                              setState(() {
                                showSearchResults = false;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  if (!showSearchResults)
                    const SizedBox(
                      height: 60,
                    )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.group_invited,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                    '$memberCounter ${AppLocalizations.of(context)!.off} ${widget.members}'),
              ],
            ),
            Expanded(
                child: ListView.separated(
              itemCount: users.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(
                    user['name'],
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  subtitle: Text(
                    user['document'],
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        users.removeAt(index);
                        memberCounter--;
                      });
                    },
                  ),
                );
              },
            ))
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => isLoading.value == false
            ? SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _sendMembersInvites(
                        users.map((user) => user['id'].toString()).toList());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
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
      ),
    );
  }

  Future<void> _getUser(String document) async {
    setState(() {
      getMember(true);
    });

    try {
      final Map<String, dynamic> data = await fetchUser(
          document.replaceAll('.', '').replaceAll('/', '').replaceAll('-', ''));

      _name = data['name'];
      _document = data['document'];
      _id = data['user']['id'].toString();

      showSearchResults = true;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      setState(() {
        getMember(false);
      });
    }
  }

  Future<void> _addUserToList() async {
    try {
      users.add({
        'name': _name,
        'document': _document,
        'id': _id,
      });
      setState(() {
        _name = '';
        _document = '';
        _id = '';
        memberCounter++;
      });
      _controller.clear();
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      _controller.clear();
    }
  }

  _sendMembersInvites(List<String> ids) async {
    setState(() {
      isLoading(true);
    });

    try {
      String id = await SharedPreferencesFunctions.getString(key: 'groupId');
      String code = await SharedPreferencesFunctions.getString(key: 'codeLang');

      // Verificar se o membership é 'Yes' ou 'Sim' antes de criar a nova lista de IDs
      if (widget.membership == 'Yes' || widget.membership == 'Sim') {
        List<String> idsToSend = [];
        for (int i = 1; i < users.length; i++) {
          idsToSend.add(users[i]['id'].toString());
        }

        if (idsToSend.length == int.parse(widget.members) - 1) {
          await sendGroupInvite(idsToSend).then((value) => {
                if (value['message'] == 'success')
                  {
                    Get.to(() => GroupPreview(id: id),
                        transition: Transition.rightToLeft)
                  }
              });
        } else {
          Get.defaultDialog(
              title: AppLocalizations.of(context)!.message,
              content: Text(
                AppLocalizations.of(context)!.invite_content,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              confirm: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: const Text(
                        'OK',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ));
        }
      } else {
        // Se o membership não for 'Yes' ou 'Sim', enviar convites para todos os membros
        await sendGroupInvite(ids).then((value) => {
              if (value['message'] == 'success')
                {
                  Get.to(() => GroupPreview(id: id),
                      transition: Transition.rightToLeft)
                }
            });
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      setState(() {
        isLoading(false);
      });
    }
  }
}
