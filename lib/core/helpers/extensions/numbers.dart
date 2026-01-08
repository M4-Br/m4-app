import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:intl/intl.dart';

final _brlFormatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

extension StringRobustCurrencyExtension on String {
  double toCurrencyDouble() {
    try {
      if (isEmpty) return 0.0;
      if (contains('.')) {
        return double.tryParse(this) ?? 0.0;
      }
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

extension DoubleCurrencyExtension on double {
  String toBRL() {
    return _brlFormatter.format(this);
  }

  String toCentsString() {
    return (this * 100).toStringAsFixed(0);
  }
}
