import '../../features/attendance/domain/entities/attendance_entity.dart';

class SortingFilterObject {
  //bisa buat filter
  bool isDateAbsent({
    required DateTime targetDate,
    required List<AttendanceEntity> attendanceList,
  }) {
    return !attendanceList.any((entity) {
      final attendanceDate = DateTime.parse(entity.attendToday.timeStamp);
      return attendanceDate.year == targetDate.year &&
          attendanceDate.month == targetDate.month &&
          attendanceDate.day == targetDate.day;
    });
  }

  //daftar hadir
  List<DateTime> absentAttendFilter({
    required String stringStartDate,
    required List<AttendanceEntity> attendanceList,
  }) {
    // value date
    final stringEndDate = DateTime.now().toString();
    //konversi string ke date time
    final startDate = DateTime.parse(stringStartDate);
    final endDate = DateTime.parse(stringEndDate);
    // Buat daftar semua tanggal antara startDate dan endDate
    final allDates = List.generate(
      endDate.difference(startDate).inDays + 1,
      (index) => startDate.add(Duration(days: index)),
    );

    // Filter tanggal yang tidak ada di attendanceList
    final absentDates = allDates.where((date) {
      return !attendanceList.any((entity) {
        final attendanceDate = DateTime.parse(entity.attendToday.timeStamp);
        return attendanceDate.year == date.year &&
            attendanceDate.month == date.month &&
            attendanceDate.day == date.day;
      });
    }).toList();

    absentDates.sort((a, b) => b.compareTo(a)); // Descending filter
    return absentDates;
  }

  List<AttendanceEntity> attendanceLateFilter({
    required List<AttendanceEntity> attendances,
    required int hour,
    required int minute,
  }) {
    return attendances.where(
      (attendance) {
        final dateTime = DateTime.parse(attendance.attendToday.checkIn);
        return dateTime.hour > hour ||
            (dateTime.hour == hour && dateTime.minute > minute);
      },
    ).toList()
      ..sort((a, b) {
        final dateTimeA = DateTime.parse(a.attendToday.checkIn);
        final dateTimeB = DateTime.parse(b.attendToday.checkIn);
        return dateTimeB.compareTo(dateTimeA); // Descending order
      });
  }

  List<AttendanceEntity> attendanceSortingFilter({
    required List<AttendanceEntity> attendances,
  }) {
    return attendances
      ..sort((a, b) {
        final dateTimeA = DateTime.parse(a.attendToday.checkIn);
        final dateTimeB = DateTime.parse(b.attendToday.checkIn);
        return dateTimeB.compareTo(dateTimeA); // Descending order
      });
  }
}
