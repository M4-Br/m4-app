
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_screen.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditRequest extends StatelessWidget {
  const CreditRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(title: 'credit_credit'.toUpperCase().tr, backPage: () => Get.offAll(() => const HomeViewPage(), transition: Transition.leftToRight),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/ic_pix_success.png',
            height: 120,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'credit_requested'.tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'credit_request_wait'.tr,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                Get.to(() => const GroupsScreen(),
                    transition: Transition.rightToLeft);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: Text(
                'credit_groups'.toUpperCase().tr,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
        ),
      ),
    );
  }
}
