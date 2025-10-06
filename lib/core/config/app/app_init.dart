// file: app_init.dart

import 'package:app_flutter_miban4/core/config/app/app.dart';
import 'package:app_flutter_miban4/core/config/auth/controller/user_controller.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppSetup {
  static Future<void> setup() async {
    await GetStorage.init();
    AppLogger.I().debug('GetStorage initialized');

    Get.put(UserController(), permanent: true);
    AppLogger.I().debug('User Controller Initialized');

    await SentryFlutter.init(
      (options) => options
        ..dsn =
            'https://e38025a88a4e4fcabbc1ed18f05b3b31@app.glitchtip.com/12134'
        ..tracesSampleRate = 1.0
        ..enableAutoSessionTracking = false,
      appRunner: () => runApp(const MiBan4()),
    );

    AppLogger.I().debug('Sentry initialized');
  }
}
