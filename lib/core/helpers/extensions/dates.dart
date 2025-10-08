import 'package:intl/intl.dart';

extension DateTimeFormattingExtension on DateTime {
  String toYYYYMMDD() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    return formatter.format(this);
  }
}
