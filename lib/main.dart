import 'package:app_flutter_miban4/data/bindings/bindings.dart';
import 'package:app_flutter_miban4/l18n/app_strings.dart';
import 'package:app_flutter_miban4/ui/controllers/login/user_controller.dart';
import 'package:app_flutter_miban4/ui/routes/app_pages.dart';
import 'package:app_flutter_miban4/ui/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await GetStorage.init();
  SentryFlutter.init(
    (options) => options
      ..dsn = 'https://e38025a88a4e4fcabbc1ed18f05b3b31@app.glitchtip.com/12134'
      ..tracesSampleRate = 1.0
      ..enableAutoSessionTracking = false,
    appRunner: () {
      runApp(MiBan4());
    },
  );
}

class MiBan4 extends StatelessWidget {
  MiBan4({super.key});

  final UserController userController = UserController();

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String? savedLanguage = box.read('language');

    Locale initialLocale =
        savedLanguage != null ? Locale(savedLanguage) : Get.deviceLocale!;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: GetMaterialApp(
        initialBinding: AppBindings(),
        locale: initialLocale,
        translations: Messages(),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        getPages: AppPages.pages,
      ),
    );
  }
}
