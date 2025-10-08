import 'package:app_flutter_miban4/core/config/log/logger.dart';

extension StringRobustCurrencyExtension on String {
  double toCurrencyDouble() {
    try {
      final numericString = replaceAll(RegExp(r'[^0-9]'), '');

      if (numericString.isEmpty) {
        return 0.0;
      }

      final intValue = int.parse(numericString);

      return intValue / 100.0;
    } catch (e) {
      AppLogger.I().error('Converter String to Double', e, StackTrace.current);
      return 0.0;
    }
  }
}
