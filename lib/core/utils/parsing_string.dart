part of 'utils.dart';


class ParsingString {
  String formatCurrency(int number) {
    final formatter = NumberFormat.decimalPattern('id');
    return formatter.format(number);
  }

  parsingTimeToYMD(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final format = DateFormat('y-M-d');
    final clockString = format.format(dateTime);
    return clockString;
  }

  String formatDateTimeIDFormat(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String date = DateFormat('d MMMM yyyy', 'id_ID').format(dateTime);
    return date;
  }

  String formatDateTimeIDFormatFull(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String time = DateFormat('HH:mm', 'id_ID').format(dateTime);
    String date = DateFormat('HH:mm EEEE, d MMMM yyyy', 'id_ID').format(dateTime);
    return "$time WIB, $date";
  }

  String formatDateTimeIDOnlyMonthYear(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String date = DateFormat('MMMM yyyy', 'id_ID').format(dateTime);
    return date;
  }

  String formatDateTimeHHmm(String dateTimeString) {
    if (dateTimeString == "") {
      return "";
    }
    DateTime dateTime = DateTime.parse(dateTimeString);
    String time = DateFormat('HH:mm').format(dateTime);
    return time;
  }
}
