import 'package:app_flutter_miban4/core/helpers/extensions/dates.dart';
import 'package:intl/intl.dart';

final _brlFormatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

extension DoubleCurrencyExtension on double {
  String toBRL() {
    return _brlFormatter.format(this);
  }
}

extension IntCurrencyExtension on int {
  String centsToBRL() {
    final double valueInReais = this / 100.0;

    return _brlFormatter.format(valueInReais);
  }
}

extension StringCurrencyExtension on String {
  int toCents() {
    final String digitsOnly = replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.isEmpty) {
      return 0;
    }

    return int.parse(digitsOnly);
  }
}

extension StringDateExtension on String {
  String toVoucherFormat() {
    try {
      final dateTime = DateTime.parse(this);
      return dateTime.toVoucherFormat();
    } catch (e) {
      return this;
    }
  }
}

extension EmailMasking on String {
  String get maskedEmail {
    if (isEmpty || !contains('@')) return this;

    final parts = split('@');
    final localPart = parts[0];
    final domainPart = parts[1];
    if (localPart.length <= 3) {
      return '${localPart[0]}***@$domainPart';
    }

    final prefix = localPart.substring(0, 4);
    final suffix = localPart.substring(localPart.length - 2);
    return '$prefix****$suffix@$domainPart';
  }
}
