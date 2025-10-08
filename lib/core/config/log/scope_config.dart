import 'package:app_flutter_miban4/core/config/auth/model/user.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ScopeConfig {
  const ScopeConfig._();

  static Future<void> setup(User user) async {
    await Sentry.configureScope((scope) {
      scope.setUser(SentryUser(
        id: user.payload.document,
        username: user.payload.fullName,
        email: user.payload.email,
      ));
    });
  }
}
