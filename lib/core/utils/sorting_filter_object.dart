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

  List<DateTime> absentAttendanceFilter({
    DateTime? selectedMonth,
    required String stringActiveWork,
    required List<AttendanceEntity> listAttendance,
  }) {
    final activeWorkDate = DateTime.parse(stringActiveWork);
    if (selectedMonth != null) {
      //convert string to date time
      // final selectedMonth = DateTime.parse(stringSelectedMonth);

      // Mendapatkan tanggal awal dan akhir bulan yang dipilih
      DateTime startOfMonth =
          DateTime(selectedMonth.year, selectedMonth.month, 1);
      DateTime endOfMonth =
          DateTime(selectedMonth.year, selectedMonth.month + 1, 0);

      // Menyimpan tanggal-tanggal ketidakhadiran
      List<DateTime> absentDates = [];

      // Hitung jumlah ketidakhadiran dalam bulan yang dipilih
      for (var attendance in listAttendance) {
        DateTime attendanceDate =
            DateTime.parse(attendance.attendToday.timeStamp);

        // Pastikan attendanceDate berada dalam rentang bulan yang dipilih
        if (attendanceDate.isBefore(startOfMonth) ||
            attendanceDate.isAfter(endOfMonth)) {
          continue; // Skip jika tanggal tidak dalam bulan yang dipilih
        }

        // Validasi ketidakhadiran berdasarkan kondisi activeWork dan tanggal sebelum hari ini
        if (attendanceDate.isBefore(activeWorkDate) ||
            attendanceDate.isAfter(DateTime.now())) {
          continue; // Skip jika tanggal sebelum active work atau setelah hari ini
        }

        // Jika tanggal jatuh pada hari Sabtu, anggap sebagai libur
        if (attendanceDate.weekday == DateTime.saturday) {
          continue; // Skip jika hari Sabtu
        }

        // Jika tidak ada absensi, masukkan tanggalnya ke dalam daftar ketidakhadiran
        absentDates.add(attendanceDate);
      }
      absentDates.sort((a, b) => b.compareTo(a)); // Descending filter
      return absentDates;
    } else {
      // Buat daftar semua tanggal antara startDate dan endDate
      final allDates = List.generate(
        DateTime.now().difference(activeWorkDate).inDays + 1,
        (index) => activeWorkDate.add(Duration(days: index)),
      );

      // Filter tanggal yang tidak ada di attendanceList
      final absentDates = allDates.where((date) {
        return !listAttendance.any((entity) {
          final attendanceDate = DateTime.parse(entity.attendToday.timeStamp);
          return attendanceDate.year == date.year &&
              attendanceDate.month == date.month &&
              attendanceDate.day == date.day;
        });
      }).toList();

      absentDates.sort((a, b) => b.compareTo(a)); // Descending filter
      return absentDates;
    }
  }

  List<AttendanceEntity> lateAttendanceFilter({
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
