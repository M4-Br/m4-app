import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AppLogger {
  factory AppLogger.I() => _instance;
  AppLogger._internal();
  static final _instance = AppLogger._internal();

  final Talker talker = TalkerFlutter.init(
    settings: TalkerSettings(
      enabled: !kReleaseMode,
    ),
  );

  void error(
    String method,
    Object error,
    StackTrace stackTrace, [
    Map<String, String>? parameters,
  ]) {
    if (kReleaseMode) {
      Sentry.captureException(
        error,
        stackTrace: stackTrace,
        hint: Hint.withMap({
          'method': method,
          'parameters': parameters,
        }),
      );
    } else {
      _instance.talker.handle(
        error,
        stackTrace,
        'Error $method | Params: $parameters',
      );
    }
  }

  void info(String message) {
    if (kReleaseMode) {
      Sentry.addBreadcrumb(
        Breadcrumb(
          message: message,
          level: SentryLevel.info,
          category: 'log.info',
        ),
      );
    } else {
      _instance.talker.info(message);
    }
  }

  void debug(String message) {
    if (!kReleaseMode) {
      _instance.talker.debug(message);
    }
  }
}
