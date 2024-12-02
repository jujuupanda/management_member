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
    print("!!!!!!!!!!!!!!!");
    final docRef = firebaseDB.collection("attendances");
    final listAttendance = docRef.snapshots();
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@");
    yield* listAttendance.map(
      (event) {
          print("#######################");
          print(event.size);
        for (var profileAttendance in event.docs) {
          print(profileAttendance.data());
          print("^^^^^^^^^^^^^^^^^^");
          // final attendanceProfileRef = profileAttendance.reference.collection("attendance");
          // for (var attendanceByProfile in attendanceProfileRef){
          //
          // }
        }
        return Left(ServerFailure("GAGAL"));
      },
    );
  }
}
