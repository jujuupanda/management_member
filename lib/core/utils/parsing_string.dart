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

  String formatDateTimeComplete(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String time = DateFormat('HH:mm').format(dateTime);
    String date = DateFormat('d MMMM yyyy', 'id_ID').format(dateTime);
    return "$time, $date";
  }

  String formatDateTimeHHmm(String dateTimeString) {
    if(dateTimeString == ""){
      return "";
    }
    DateTime dateTime = DateTime.parse(dateTimeString);
    String time = DateFormat('HH:mm').format(dateTime);
    return time;
  }
}
