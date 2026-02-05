import 'package:app_flutter_miban4/core/config/app/app_lifecycle_controller.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/geral/widgets/privacy_curtain.dart';
import 'package:app_flutter_miban4/l18n/app_strings.dart';
import 'package:app_flutter_miban4/core/config/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class MiBan4 extends StatelessWidget {
  const MiBan4({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String? language = box.read('language');

    Locale initialLocale;

    if (language != null) {
      if (language.contains('_')) {
        final parts = language.split('_');
        initialLocale = Locale(parts[0], parts[1]);
      } else {
        initialLocale = Locale(language);
      }
    } else {
      initialLocale = const Locale('pt', 'BR');
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: GetMaterialApp(
        locale: initialLocale,
        translations: Messages(),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        getPages: AppPages.pages,
        navigatorObservers: [
          SentryNavigatorObserver(),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
          Locale('en', 'US'),
          Locale('es', 'ES'),
        ],
        fallbackLocale: const Locale('pt', 'BR'),
        builder: (context, child) {
          return Stack(
            children: [
              child ?? const SizedBox(),
              GetX<AppLifecycleController>(
                init: AppLifecycleController(),
                builder: (controller) {
                  if (controller.isPrivacyEnabled.value) {
                    return const PrivacyCurtain();
                  }
                  return const SizedBox();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
