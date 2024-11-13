import '../../../../core/error/failure.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../core/services/token_service.dart';
import '../../../../core/utils/parsing_string.dart';
import '../models/attendance_model.dart';
import 'package:dartz/dartz.dart';

import 'attendance_data_source.dart';

class AttendanceRemoteDataSource extends AttendanceDataSource {
  final firebaseDB = FirebaseService().firebaseFirestore;

  @override
  Future<Either<Failure, AttendanceModel>> checkIn(params) async {
    try {
      final docId = ParsingString().parsingTimeToYMD(DateTime.now().toString());
      final payloadUsername = await TokenService().jwtPayloadUsername();
      final docRef = firebaseDB
          .collection("attendances")
          .doc(payloadUsername)
          .collection("attendance")
          .doc(docId);
      await docRef.set(params.attendance.toJson());
      final responseAttend = await docRef.get();

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
  Future<Either<Failure, AttendanceModel>> attendChecker(params) async {
    try {
      final docId = ParsingString().parsingTimeToYMD(DateTime.now().toString());
      final payloadUsername = await TokenService().jwtPayloadUsername();
      final docRef = firebaseDB
          .collection("attendances")
          .doc(payloadUsername)
          .collection("attendance")
          .doc(docId);
      final responseAttend = await docRef.get();

      if (responseAttend.exists) {
        final resultAttend = AttendanceModel.fromJson(responseAttend.data()!);
        return Right(resultAttend);
      }
      return Left(ServerFailure("Data presensi tidak ditemukan"));
    } catch (e) {
      return Left(
          ServerFailure("Terjadi kesalahan saat mendapatkan info presensi"));
    }
  }
}
