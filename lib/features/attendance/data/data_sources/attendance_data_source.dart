import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/use_cases/check_in_use_case.dart';
import '../../domain/use_cases/check_out_use_case.dart';
import '../models/attendance_model.dart';

abstract class AttendanceDataSource {
  Future<Either<Failure, AttendanceModel>> checkIn(CheckInParam params);

  Future<Either<Failure, AttendanceModel>> checkOut(CheckOutParam params);
}
