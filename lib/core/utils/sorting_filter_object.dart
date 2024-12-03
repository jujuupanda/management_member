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

  /// option 1
  // List<DateTime> absentAttendanceFilter({
  //   DateTime? selectedMonth,
  //   required String stringActiveWork,
  //   required List<AttendanceEntity> listAttendance,
  // }) {
  //   final activeWorkDate = DateTime.parse(stringActiveWork);
  //   if (selectedMonth != null) {
  //     // Mendapatkan tanggal awal dan akhir bulan yang dipilih
  //     DateTime startOfMonth =
  //         DateTime(selectedMonth.year, selectedMonth.month, 1);
  //     DateTime endOfMonth =
  //         DateTime(selectedMonth.year, selectedMonth.month + 1, 0);
  //
  //     // Menyimpan tanggal-tanggal ketidakhadiran
  //     List<DateTime> absentDates = [];
  //
  //     // Hitung jumlah ketidakhadiran dalam bulan yang dipilih
  //     for (var attendance in listAttendance) {
  //       DateTime attendanceDate =
  //           DateTime.parse(attendance.attendToday.timeStamp);
  //
  //       // Pastikan attendanceDate berada dalam rentang bulan yang dipilih
  //       if (attendanceDate.isBefore(startOfMonth) ||
  //           attendanceDate.isAfter(endOfMonth)) {
  //         continue; // Skip jika tanggal tidak dalam bulan yang dipilih
  //       }
  //
  //       // Validasi ketidakhadiran berdasarkan kondisi activeWork dan tanggal sebelum hari ini
  //       if (attendanceDate.isBefore(activeWorkDate) ||
  //           attendanceDate.isAfter(DateTime.now())) {
  //         continue; // Skip jika tanggal sebelum active work atau setelah hari ini
  //       }
  //
  //       // Jika tanggal jatuh pada hari Sabtu, anggap sebagai libur
  //       if (attendanceDate.weekday == DateTime.saturday) {
  //         continue; // Skip jika hari Sabtu
  //       }
  //
  //       // Jika tidak ada absensi, masukkan tanggalnya ke dalam daftar ketidakhadiran
  //       absentDates.add(attendanceDate);
  //     }
  //     absentDates.sort((a, b) => b.compareTo(a)); // Descending filter
  //     return absentDates;
  //   } else {
  //     // Buat daftar semua tanggal antara startDate dan endDate
  //     final allDates = List.generate(
  //       DateTime.now().difference(activeWorkDate).inDays + 1,
  //       (index) => activeWorkDate.add(Duration(days: index)),
  //     );
  //
  //     // Filter tanggal yang tidak ada di attendanceList
  //     final absentDates = allDates.where((date) {
  //       return !listAttendance.any((entity) {
  //         final attendanceDate = DateTime.parse(entity.attendToday.timeStamp);
  //         return attendanceDate.year == date.year &&
  //             attendanceDate.month == date.month &&
  //             attendanceDate.day == date.day;
  //       });
  //     }).toList();
  //
  //     absentDates.sort((a, b) => b.compareTo(a)); // Descending filter
  //     return absentDates;
  //   }
  // }
  /// option 2
//   List<DateTime> absentAttendanceFilter({
//     DateTime? selectedMonth,
//     required String stringActiveWork,
//     required List<AttendanceEntity> listAttendance,
//   }) {
//     // Format tanggal
//     DateFormat dateFormat = DateFormat('yyyy-MM-dd');
//     final activeWorkDate = DateTime.parse(stringActiveWork);
//
//     // Cek apakah bulan valid
//     if (selectedMonth!.isBefore(activeWorkDate) ||
//         selectedMonth.month > DateTime.now().month) {
//       return []; // Tidak valid jika sebelum active work date atau lebih besar dari bulan sekarang
//     }
//
//     // Inisialisasi list untuk menyimpan tanggal yang tidak hadir
//     List<DateTime> absentDates = [];
//
//     // Loop untuk mengecek tanggal-tanggal dalam bulan yang dipilih
//     DateTime firstDayOfMonth =
//         DateTime(selectedMonth.year, selectedMonth.month, 1);
//     DateTime lastDayOfMonth = DateTime(selectedMonth.year,
//         selectedMonth.month + 1, 0); // Hari terakhir bulan tersebut
//
//     // Tambahkan tanggal yang tidak ada dalam daftar kehadiran
//     for (DateTime date = firstDayOfMonth;
//         date.isBefore(lastDayOfMonth) || date.isAtSameMomentAs(lastDayOfMonth);
//         date = date.add(const Duration(days: 1))) {
//       // Cek jika hari bukan Sabtu atau Minggu, dan tidak ada di list kehadiran
//       bool isWeekend =
//           date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
//       bool isAbsent = !listAttendance.any((attendance) => date
//           .isAtSameMomentAs(DateTime.parse(attendance.attendToday.timeStamp)));
//
//       if (!isWeekend && isAbsent) {
//         absentDates.add(date);
//       }
//     }
//     absentDates.sort((a, b) => b.compareTo(a));
//     return absentDates;
//   }
  ///option 3
  List<DateTime> absentAttendanceFilter({
    DateTime? selectedMonth,
    required String stringActiveWork,
    required List<AttendanceEntity> listAttendance,
  }) {
    final activeWorkDate = DateTime.parse(stringActiveWork);

    // Jika bulan yang dipilih ada
    if (selectedMonth != null) {
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

        // Jika tanggal jatuh pada hari Sabtu atau Minggu, anggap sebagai libur
        if (attendanceDate.weekday == DateTime.saturday ||
            attendanceDate.weekday == DateTime.sunday) {
          continue; // Skip jika hari Sabtu atau Minggu
        }

        // Jika ada absensi, tandai tanggalnya
        absentDates.add(attendanceDate);
      }

      // Menghasilkan semua tanggal dalam bulan yang dipilih
      List<DateTime> allDatesInMonth = [];
      for (DateTime date = startOfMonth;
          date.isBefore(endOfMonth.add(const Duration(days: 1)));
          date = date.add(const Duration(days: 1))) {
        if (date.weekday != DateTime.saturday &&
            date.weekday != DateTime.sunday) {
          allDatesInMonth
              .add(date); // Tambahkan tanggal kerja (selain Sabtu dan Minggu)
        }
      }

      // Filter tanggal yang tidak hadir
      List<DateTime> finalAbsentDates = allDatesInMonth.where((date) {
        return !absentDates
            .any((attendanceDate) => attendanceDate.isAtSameMomentAs(date));
      }).toList();

      finalAbsentDates.sort((a, b) => b.compareTo(a)); // Descending filter
      return finalAbsentDates;
    } else {
      // Membuat daftar semua tanggal antara activeWorkDate dan tanggal hari ini
      final allDates = List.generate(
        DateTime.now().difference(activeWorkDate).inDays + 1,
            (index) => activeWorkDate.add(Duration(days: index)),
      );

      // Menyaring tanggal yang tidak ada di daftar kehadiran dan tidak jatuh pada hari Sabtu atau Minggu
      final absentDates = allDates.where((date) {
        // Mengecek jika tanggal jatuh pada Sabtu atau Minggu, dianggap libur
        if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
          return false; // Skip jika Sabtu atau Minggu
        }

        // Mengecek apakah tanggal tersebut ada dalam daftar kehadiran
        return !listAttendance.any((entity) {
          final attendanceDate = DateTime.parse(entity.attendToday.timeStamp);
          return attendanceDate.year == date.year &&
              attendanceDate.month == date.month &&
              attendanceDate.day == date.day;
        });
      }).toList();

      // Mengurutkan tanggal ketidakhadiran secara menurun (descending)
      absentDates.sort((a, b) => b.compareTo(a));

      return absentDates;
    }
  }

  List<AttendanceEntity> lateAttendanceFilter({
    required List<AttendanceEntity> attendances,
    required int hour,
    required int minute,
  }) {
    return attendances.where((attendance) {
      final dateTime = DateTime.parse(attendance.attendToday.checkIn);

      // Cek jika hari Sabtu atau Minggu, maka tidak dihitung
      if (dateTime.weekday == DateTime.saturday ||
          dateTime.weekday == DateTime.sunday) {
        return false;
      }

      // Cek apakah jam lebih dari jam yang diberikan, atau sama jamnya tapi menit lebih dari menit yang diberikan
      return dateTime.hour > hour ||
          (dateTime.hour == hour && dateTime.minute > minute);
    }).toList()
      ..sort((a, b) {
        final dateTimeA = DateTime.parse(a.attendToday.checkIn);
        final dateTimeB = DateTime.parse(b.attendToday.checkIn);
        return dateTimeB.compareTo(dateTimeA); // Urutan menurun (descending)
      });
  }

  List<AttendanceEntity> attendanceSortingFilter({
    required List<AttendanceEntity> attendances,
  }) {
    return attendances
        // Menyaring entri yang tidak termasuk Sabtu dan Minggu
        .where((attendance) {
      final dateTime = DateTime.parse(attendance.attendToday.checkIn);
      return dateTime.weekday != DateTime.saturday &&
          dateTime.weekday != DateTime.sunday;
    }).toList()
      // Mengurutkan daftar berdasarkan waktu secara menurun (descending)
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
