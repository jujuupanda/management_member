import '../../../../core/error/failure.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../../attendance/data/models/attendance_model.dart';
import 'package:dartz/dartz.dart';

import 'manage_attendance_data_source.dart';

class ManageAttendanceRemoteDataSource extends ManageAttendanceDataSource {
  final firebaseDB = DatabaseService().firebaseFirestore;

  @override
  Stream<Either<Failure, List<AttendanceModel>>> getAllAttendance(
      NoParam params) async* {
    // final docRef = firebaseDB.collection("attendances");
    // final listAttendance = docRef.snapshots();
    // yield* listAttendance.map(
    //   (event) {
    //     List<AttendanceModel> allAttendanceData = [];
    //     for (var userDoc in event.docs) {
    //       final docRef = userDoc.reference.collection("attendance");
    //       final allAttendance = docRef.snapshots();
    //       allAttendance.map(
    //         (event) => print(event.docs.length),
    //       );
    //     }
    //     return Left(ServerFailure("GAGAL"));
    //   },
    // );
    try {
      final docRef = firebaseDB.collection("attendances");
      final listAttendance = docRef.snapshots();

      await for (var event in listAttendance) {
        // Proses operasi asinkron di luar yield
        List<AttendanceModel> attendanceList = [];

        for (var profileAttendance in event.docs) {
          final subCollectionRef = profileAttendance.reference.collection("attendance");
          final subCollectionSnapshot = await subCollectionRef.get(); // Operasi asinkron

          for (var attendanceDoc in subCollectionSnapshot.docs) {
            attendanceList.add(AttendanceModel.fromJson(attendanceDoc.data()));
          }
        }

        print(attendanceList.length);
        // Mengembalikan hasil yang diinginkan
        yield Right(attendanceList); // Menggunakan yield untuk mengirim data
      }
    } catch (e) {
      yield Left(ServerFailure("Terjadi kesalahan saat mengambil data"));
    }
  }
}
