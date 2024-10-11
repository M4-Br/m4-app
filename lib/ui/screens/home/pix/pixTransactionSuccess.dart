import 'package:app_flutter_miban4/data/api/balance/balanceAPI.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixCopyPaste.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class PixTransactionSuccess extends StatefulWidget {
  late Map<String, dynamic>? transfer;

  PixTransactionSuccess({Key? key, this.transfer}) : super(key: key);

  @override
  State<PixTransactionSuccess> createState() => _PixTransactionSuccessState();
}

class _PixTransactionSuccessState extends State<PixTransactionSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarDefault(
        title: 'PIX',
        backPage: () =>
            Get.off(() => HomeViewPage(), transition: Transition.leftToRight),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'Pix realizado com sucesso!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Data',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  widget.transfer!['transaction_date'].toString(),
                  style: const TextStyle(
                      color: Colors.deepOrange,
                      decoration: TextDecoration.underline,
                      fontSize: 16),
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'VER COMPROVANTE',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                await getBalance().then((balance) {
                  if (balance.success == true) {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: PixCopyPaste(balance: balance),
                            type: PageTransitionType.rightToLeft));
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'FAZER OUTRO PIX',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
