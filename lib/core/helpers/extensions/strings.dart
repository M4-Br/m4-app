import 'package:intl/intl.dart';

extension DoubleCurrencyExtension on double {
  String toBRL() {
    final formatador = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return formatador.format(this);
  }
}
