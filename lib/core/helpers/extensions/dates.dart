import 'package:intl/intl.dart';

extension DateTimeFormattingExtension on DateTime {
  String toYYYYMMDD() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    return formatter.format(this);
  }

  String toDDMMYYYY() {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(this);
  }
}
