import '../../../../core/error/failure.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../../attendance/data/models/attendance_model.dart';
import 'package:dartz/dartz.dart';

import '../../../profile/data/models/user_model.dart';
import 'manage_attendance_data_source.dart';

class ManageAttendanceRemoteDataSource extends ManageAttendanceDataSource {
  final firebaseDB = DatabaseService().firebaseFirestore;

  @override
  Stream<Either<Failure, Map<String, dynamic>>> getAllAttendance(
      NoParam params) async* {
    try {
      final docRef = firebaseDB.collection("attendances");
      final listAttendance = docRef.snapshots();

      await for (var event in listAttendance) {
        List<AttendanceModel> attendanceList = [];
        List<UserModel> userList = [];

        for (var profileAttendance in event.docs) {
          final subCollectionRef =
              profileAttendance.reference.collection("attendance");
          final subCollectionSnapshot = await subCollectionRef.get();
          final userDocRef = firebaseDB.collection("users").where(
                "username",
                isEqualTo: profileAttendance.id,
              );
          final userResponse = await userDocRef.get();
          for (var userProfile in userResponse.docs) {
            userList.add(UserModel.fromJson(userProfile.data()));
          }
          for (var attendanceDoc in subCollectionSnapshot.docs) {
            attendanceList.add(AttendanceModel.fromJson(attendanceDoc.data()));
          }
        }
        yield Right({
          "attendanceList": attendanceList,
          "userList": userList,
        });
      }
    } catch (e) {
      yield Left(ServerFailure("Terjadi kesalahan saat mengambil data"));
    }
  }
}
