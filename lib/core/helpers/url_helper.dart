import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UrlHelper {
  static String get url {
    if (kDebugMode) {
      return dotenv.env['URL_HOMOL'] ?? '';
    }

    return const String.fromEnvironment('URL_HOMOL');
  }
}
