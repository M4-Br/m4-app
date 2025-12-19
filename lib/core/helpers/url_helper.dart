import 'package:flutter_dotenv/flutter_dotenv.dart';

class UrlHelper {
  static String get url {
    const fromEnv = String.fromEnvironment('APP_RELEASE');

    if (fromEnv.isNotEmpty) {
      return fromEnv;
    }

    return dotenv.env['URL_HOMOL'] ?? '';
  }
}
