import 'package:app_flutter_miban4/data/api/pix/pixCreateKey.dart';
import 'package:app_flutter_miban4/data/model/pix/pixCreateKey.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixKeyManager.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixMyKeys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class PixNewKey extends StatefulWidget {
  late String? pixKey;

  PixNewKey({Key? key, this.pixKey}) : super(key: key);

  @override
  State<PixNewKey> createState() => _PixNewKeyState();
}

class _PixNewKeyState extends State<PixNewKey> {
  final TextEditingController _newKey = TextEditingController();

  @override
  void dispose() {
    _newKey.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
          title: AppLocalizations.of(context)!.pix_registerKey,
          backPage: () => Get.off(() => const PixMyKeys(),
              transition: Transition.leftToRight)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _newKey,
              style: const TextStyle(color: Colors.black, fontSize: 20),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                contentPadding: EdgeInsets.zero,
                labelText: AppLocalizations.of(context)!.pix_newKey,
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                hintText: '',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    createKey(_newKey.text.toString(), widget.pixKey!)
                        .then((PixCreateKey result) {
                      if (result.success == true) {
                        Get.off(() => const PixKeyManager(),
                            transition: Transition.leftToRight);
                      } else {
                        Navigator.pop(context);
                      }
                    });
                    return AlertDialog.adaptive(
                      title:
                      Text(AppLocalizations.of(context)!.pix_waitNewKey),
                      content: const CircularProgressIndicator(),
                    );
                  });
            },
            child: Text(
              AppLocalizations.of(context)!.pix_createNewKey,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
