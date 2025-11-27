import 'package:app_flutter_miban4/core/config/app/app_init.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  SentryWidgetsFlutterBinding.ensureInitialized();

  await AppSetup.setup();
}
