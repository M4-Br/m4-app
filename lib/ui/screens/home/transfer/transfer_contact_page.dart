
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_new_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransferContactPage extends StatefulWidget {
  const TransferContactPage({super.key});

  @override
  State<TransferContactPage> createState() => _TransferContactPageState();
}

class _TransferContactPageState extends State<TransferContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.transfer,
        backPage: () =>
            Get.off(() => const HomeViewPage(), transition: Transition.leftToRight),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                AppLocalizations.of(context)!.transfer_to,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  AppLocalizations.of(context)!.transfer_noOne,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 24,
                    ),
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const TransferNewContactPage(),
                          transition: Transition.rightToLeft);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.transfer_new_contact,
                      style: const TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
