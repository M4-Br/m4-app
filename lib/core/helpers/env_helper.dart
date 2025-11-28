import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get sentryDns {
    if (kDebugMode) {
      return dotenv.env['SENTRY_DNS'] ?? '';
    }
    return const String.fromEnvironment('SENTRY_DNS');
  }
}
