import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart'; // 1. Importe o pacote do Sentry
import 'package:talker_flutter/talker_flutter.dart';

class AppLogger {
  factory AppLogger.I() => _instance;

  AppLogger._internal();

  final Talker talker = TalkerFlutter.init();
  static final _instance = AppLogger._internal();

  void error(
    String method,
    Object error,
    StackTrace stackTrace, [
    Map<String, String>? parameters,
  ]) {
    if (kDebugMode) {
      _instance.talker.handle(
        error,
        stackTrace,
        'Error $method $parameters. $error',
      );
    }

    Sentry.captureException(
      error,
      stackTrace: stackTrace,
      hint: Hint.withMap({
        'method': method,
        'parameters': parameters,
        'timestamp': DateTime.now().toIso8601String(),
      }),
    );
  }

  void info(String message) {
    if (kDebugMode) {
      _instance.talker.info(message);
    }

    Sentry.addBreadcrumb(
      Breadcrumb(
          message: message, level: SentryLevel.info, category: 'log.info'),
    );
  }

  void debug(String message) {
    if (kDebugMode) {
      _instance.talker.debug(message);
    }
  }
}
