// file: main.dart

import 'package:app_flutter_miban4/core/config/app/app_init.dart';
import 'package:flutter/material.dart'; // Import necessário

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppSetup.setup();
}
