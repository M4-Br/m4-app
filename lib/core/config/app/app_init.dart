import 'package:app_flutter_miban4/core/config/app/app.dart';
import 'package:app_flutter_miban4/core/config/app/app_lifecycle_controller.dart';
import 'package:app_flutter_miban4/core/config/auth/controller/user_rx.dart';
import 'package:app_flutter_miban4/core/config/auth/service/auth_service.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/helpers/controller/tracking_controller.dart';
import 'package:app_flutter_miban4/core/helpers/sentry_helper.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:app_flutter_miban4/features/completeProfile/controller/redirect_complete_profile_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppSetup {
  static Future<void> setup() async {
    await dotenv.load(fileName: '.env');

    await GetStorage.init();
    AppLogger.I().debug('GetStorage initialized');

    await Get.putAsync(() => AuthService().init());
    AppLogger.I().debug('Auth Service Initialized');

    Get.put(AppLifecycleController(), permanent: true);

    Get.put(TrackerController(), permanent: true);

    Get.put(UserRx(), permanent: true);
    AppLogger.I().debug('User RX Initialized');

    Get.put(BalanceRx(), permanent: true);
    AppLogger.I().debug('Balance RX Initialized');

    Get.put(RedirectCompleteProfileController(), permanent: true);
    AppLogger.I().debug('Complete Profiler Initialized');

    if (kDebugMode) {
      AppLogger.I()
          .debug('🚀 Modo Debug: Sentry Desativado. Rodando App direto.');
      runApp(const MiBan4());
    } else {
      AppLogger.I().debug('🛡️ Modo Release: Inicializando Sentry...');

      await SentryFlutter.init(
        (options) => options
          ..dsn = Env.sentryDns
          ..tracesSampleRate = 1.0
          ..enableAutoSessionTracking = true
          ..environment = 'production',
        appRunner: () => runApp(const MiBan4()),
      );
    }
  }
}
