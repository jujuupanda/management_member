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
    DateTime? startDate,
    required String activeWork,
    required List<AttendanceEntity> attendanceList,
  }) {
    // value date
    final stringEndDate = DateTime.now().toString();
    //konversi string ke date time
    final activeWorkDate = DateTime.parse(activeWork);
    final endDateNow = DateTime.parse(stringEndDate);
    if (startDate != null) {
      final stringStartDate = startDate.toString();

      final startSelectedDateInMonth = DateTime.parse(_getFirstDateOfMonthFormatted(stringStartDate));
      final endSelectedDateInMonth =
          DateTime.parse(_getLastDateOfMonthFormatted(stringStartDate));

      //pengecekan tanggal yang tidak sesuai dengan active work
      if (startSelectedDateInMonth.isBefore(activeWorkDate) &&
          startSelectedDateInMonth.month == activeWorkDate.month) {
        // Buat daftar semua tanggal antara startDate dan endDate
        final allDates = List.generate(
          endSelectedDateInMonth.difference(activeWorkDate).inDays + 1,
          (index) => activeWorkDate.add(Duration(days: index)),
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
      if (startSelectedDateInMonth.isBefore(activeWorkDate) &&
          startSelectedDateInMonth.month != activeWorkDate.month) {
        return [];
      }
      if (startSelectedDateInMonth.isAfter(activeWorkDate) &&
          endDateNow.isAfter(startSelectedDateInMonth)) {
        // Buat daftar semua tanggal antara startDate dan endDate
        final allDates = List.generate(
          endDateNow.difference(startSelectedDateInMonth).inDays + 1,
          (index) => startSelectedDateInMonth.add(Duration(days: index)),
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
      if (startSelectedDateInMonth.isAfter(activeWorkDate) &&
          endDateNow.isBefore(startSelectedDateInMonth)) {
        return [];
      }
    }

    // Buat daftar semua tanggal antara startDate dan endDate
    final allDates = List.generate(
      endDateNow.difference(activeWorkDate).inDays + 1,
      (index) => activeWorkDate.add(Duration(days: index)),
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

String _getLastDateOfMonthFormatted(String inputDate) {
  DateTime parsedDate = DateTime.parse(inputDate);
  int year = parsedDate.year;
  int month = parsedDate.month;

  DateTime lastDate = DateTime(year, month + 1, 0);

  // Format hasil
  return "${lastDate.year}-${lastDate.month.toString().padLeft(2, '0')}-${lastDate.day.toString().padLeft(2, '0')} ${lastDate.hour.toString().padLeft(2, '0')}:${lastDate.minute.toString().padLeft(2, '0')}:${lastDate.second.toString().padLeft(2, '0')}.${lastDate.millisecond.toString().padLeft(3, '0')}";
}

String _getFirstDateOfMonthFormatted(String inputDate) {
  DateTime parsedDate = DateTime.parse(inputDate);
  int year = parsedDate.year;
  int month = parsedDate.month;

  // Tanggal pertama bulan tersebut
  DateTime firstDate = DateTime(year, month, 1);

  // Format hasil
  return "${firstDate.year}-${firstDate.month.toString().padLeft(2, '0')}-${firstDate.day.toString().padLeft(2, '0')} ${firstDate.hour.toString().padLeft(2, '0')}:${firstDate.minute.toString().padLeft(2, '0')}:${firstDate.second.toString().padLeft(2, '0')}.${firstDate.millisecond.toString().padLeft(3, '0')}";
}