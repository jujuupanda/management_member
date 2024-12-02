part of 'attendance_data_source.dart';

class AttendanceRemoteDataSource extends AttendanceDataSource {
  final firebaseDB = DatabaseService().firebaseFirestore;

  @override
  Future<Either<Failure, AttendanceModel>> checkIn(params) async {
    try {
      final docId = ParsingString().parsingTimeToYMD(DateTime.now().toString());
      final payloadUsername = await TokenService().jwtPayloadUsername();
      final docRef = firebaseDB.collection("attendances").doc(payloadUsername);
      final docRefSubCollection = firebaseDB
          .collection("attendances")
          .doc(payloadUsername)
          .collection("attendance")
          .doc(docId);
      await docRef.set({"time_stamp": DateTime.now().toString()});
      await docRefSubCollection.set(params.attendance.toJson());

      final responseAttend = await docRefSubCollection.get();

      if (responseAttend.exists) {
        final resultAttend = AttendanceModel.fromJson(responseAttend.data()!);
        return Right(resultAttend);
      }
      return Left(ServerFailure("Data presensi tidak ditemukan"));
    } catch (e) {
      return Left(
          ServerFailure("Terjadi kesalahan saat melakukan absen masuk"));
    }
  }

  @override
  Future<Either<Failure, AttendanceModel>> checkOut(params) async {
    try {
      final docId = ParsingString().parsingTimeToYMD(DateTime.now().toString());
      final payloadUsername = await TokenService().jwtPayloadUsername();
      final docRef = firebaseDB
          .collection("attendances")
          .doc(payloadUsername)
          .collection("attendance")
          .doc(docId);
      await docRef.update({"attend_today.check_out": params.checkOutTime});
      final responseAttend = await docRef.get();
      if (responseAttend.exists) {
        final resultAttend = AttendanceModel.fromJson(responseAttend.data()!);
        return Right(resultAttend);
      }
      return Left(ServerFailure("Data presensi tidak ditemukan"));
    } catch (e) {
      return Left(
          ServerFailure("Terjadi kesalahan saat melakukan absen keluar"));
    }
  }

  @override
  Stream<Either<Failure, AttendanceModel>> attendChecker(params) async* {
    final docId = ParsingString().parsingTimeToYMD(DateTime.now().toString());
    final payloadUsername = await TokenService().jwtPayloadUsername();
    final docRef = firebaseDB
        .collection("attendances")
        .doc(payloadUsername)
        .collection("attendance")
        .doc(docId);
    final responseAttend = docRef.snapshots();
    yield* responseAttend.map(
      (snapshot) {
        try {
          final attendance = AttendanceModel.fromJson(snapshot.data()!);
          return Right(attendance);
        } catch (e) {
          return Left(ServerFailure(
              "Terjadi kesalahan saat mendapatkan info presensi"));
        }
      },
    );
  }

  @override
  Stream<Either<Failure, List<AttendanceModel>>> getAttendance(params) async* {
    final payloadUsername = await TokenService().jwtPayloadUsername();
    final docRef = firebaseDB
        .collection("attendances")
        .doc(payloadUsername)
        .collection("attendance");
    final attendSnapshot = docRef.snapshots();
    yield* attendSnapshot.map(
      (snapshot) {
        try {
          final listAttendance = snapshot.docs
              .map((e) => AttendanceModel.fromJson(e.data()))
              .toList();
          return Right(listAttendance);
        } catch (e) {
          return Left(ServerFailure(
              "Terjadi kesalahan saat mendapatkan info presensi"));
        }
      },
    );
  }
}
