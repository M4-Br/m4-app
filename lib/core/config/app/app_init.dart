import 'package:app_flutter_miban4/core/config/app/app.dart';
import 'package:app_flutter_miban4/core/config/auth/controller/user_rx.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
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

    Get.put(UserRx(), permanent: true);
    AppLogger.I().debug('User RX Initialized');

    Get.put(BalanceRx(), permanent: true);
    AppLogger.I().debug('Balance RX Initialized');

    await SentryFlutter.init(
      (options) => options
        ..dsn = dotenv.env['SENTRY_DNS']
        ..tracesSampleRate = 1.0
        ..enableAutoSessionTracking = false,
      appRunner: () => runApp(const MiBan4()),
    );

    AppLogger.I().debug('Sentry initialized');
  }
}
