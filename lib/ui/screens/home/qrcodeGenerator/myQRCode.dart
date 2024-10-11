import 'package:app_flutter_miban4/data/model/userData/user.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/login/user_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyQRCode extends StatefulWidget {
  const MyQRCode({
    Key? key,
  }) : super(key: key);

  @override
  State<MyQRCode> createState() => _MyQRCodeState();
}

class _MyQRCodeState extends State<MyQRCode> {
  final UserController _userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.page36,
        backPage: () =>
            Get.off(() => HomeViewPage(), transition: Transition.leftToRight),
      ),
      body: Obx(() {
        UserData? userData = _userController.userData.value;
        return Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "@${userData?.payload.username ?? ''}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                AppLocalizations.of(context)!.myqr_description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              SvgPicture.network(
                userData!.payload.qrcode,
                height: 200,
                width: 200,
                placeholderBuilder: (BuildContext context) =>
                    const CircularProgressIndicator(),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  userData.payload.qrcode ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
