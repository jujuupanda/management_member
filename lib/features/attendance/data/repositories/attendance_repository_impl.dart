import '../../../../core/error/failure.dart';
import '../../domain/entities/attendance_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/attendance_repository.dart';
import '../data_sources/attendance_data_source.dart';

class AttendanceRepositoryImpl extends AttendanceRepository {
  AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AttendanceEntity>> checkIn(params) async {
    final checkedIn = await remoteDataSource.checkIn(params);
    return checkedIn.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, AttendanceEntity>> checkOut(params) async {
    final checkedOut = await remoteDataSource.checkOut(params);
    return checkedOut.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Stream<Either<Failure, AttendanceEntity>> attendChecker(params)  {
    final attendedChecker =  remoteDataSource.attendChecker(params);
    return attendedChecker;
  }

  @override
  Stream<Either<Failure, List<AttendanceEntity>>> getAttendance(params) {
    final listAllAttendance = remoteDataSource.getAttendance(params);
    return listAllAttendance;
  }
}
