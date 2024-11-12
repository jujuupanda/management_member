import 'package:intl/intl.dart';

class ParsingString {
  String formatCurrency(int number) {
    final formatter = NumberFormat.decimalPattern('id');
    return formatter.format(number);
  }

  parsingTimeToYMD(String date) {
    final dateTime = DateTime.parse(date);

    final format = DateFormat('y-M-d');
    final clockString = format.format(dateTime);
    return clockString;
  }
}
