import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/attendance_entity.dart';
import '../use_cases/check_in_use_case.dart';
import '../use_cases/check_out_use_case.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, AttendanceEntity>> checkIn(CheckInParam params);

  Future<Either<Failure, AttendanceEntity>> checkOut(CheckOutParam params);
}
