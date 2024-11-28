part of 'utils.dart';

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

      final startDateSelectedInMonth =
          DateTime.parse(_getFirstDateOfMonthFormatted(stringStartDate));
      final endDateSelectedInMonth =
          DateTime.parse(_getLastDateOfMonthFormatted(stringStartDate));

      //pengecekan tanggal yang tidak sesuai dengan active work

      // SEBELUM ACTIVE WORK DAN BULAN TIDAK SAMA
      if (startDateSelectedInMonth.isBefore(activeWorkDate) &&
          startDateSelectedInMonth.month != activeWorkDate.month) {
        return [];
      }
      // ACTIVE WORK DI BULAN YANG SAMA TAPI TIDAK DENGAN BULAN SEKARANG
      if ((startDateSelectedInMonth.isBefore(activeWorkDate) ||
              startDateSelectedInMonth.day == activeWorkDate.day) &&
          startDateSelectedInMonth.month == activeWorkDate.month &&
          startDateSelectedInMonth.month != DateTime.now().month) {
        final allDates = List.generate(
          endDateSelectedInMonth.difference(activeWorkDate).inDays + 1,
          (index) => activeWorkDate.add(Duration(days: index)),
        );

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

      // ACTIVE WORK DI BULAN YANG SAMA DENGAN BULAN SEKARANG
      if ((startDateSelectedInMonth.isBefore(activeWorkDate) ||
              startDateSelectedInMonth.day == activeWorkDate.day) &&
          startDateSelectedInMonth.month == activeWorkDate.month &&
          startDateSelectedInMonth.month == endDateNow.month) {
        final allDates = List.generate(
          endDateNow.difference(activeWorkDate).inDays + 1,
          (index) => activeWorkDate.add(Duration(days: index)),
        );

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

      // BULAN SAAT INI
      if ((startDateSelectedInMonth.isAfter(activeWorkDate) ||
              startDateSelectedInMonth.day == activeWorkDate.day) &&
          startDateSelectedInMonth.month == DateTime.now().month) {
        final allDates = List.generate(
          endDateNow.difference(startDateSelectedInMonth).inDays + 1,
          (index) => startDateSelectedInMonth.add(Duration(days: index)),
        );

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

      // LEBIH DARI BULAN SEKARANG WORK DAN BEDA BULAN
      if (startDateSelectedInMonth.isAfter(endDateNow) &&
          endDateNow.month != startDateSelectedInMonth.month) {
        return [];
      }
    }

    // SEMUA TANGGAL

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

  List<NewsEntity> newsSortingFilter({
    required List<NewsEntity> news,
    bool? isArchive,
  }) {
    return news.where(
      (news) {
        final unArchivedNews = news.archived == (isArchive ?? false);
        return unArchivedNews;
      },
    ).toList()
      ..sort((a, b) {
        final dateTimeA = DateTime.parse(a.publishedAt);
        final dateTimeB = DateTime.parse(b.publishedAt);
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
