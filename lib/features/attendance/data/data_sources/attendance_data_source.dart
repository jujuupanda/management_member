import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../domain/use_cases/check_in_use_case.dart';
import '../../domain/use_cases/check_out_use_case.dart';
import '../models/attendance_model.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/token_service.dart';
import '../../../../core/utils/utils.dart';
part 'attendance_remote_data_source.dart';

abstract class AttendanceDataSource {
  Future<Either<Failure, AttendanceModel>> checkIn(CheckInParam params);

  Future<Either<Failure, AttendanceModel>> checkOut(CheckOutParam params);

  Stream<Either<Failure, AttendanceModel>> attendChecker(NoParam params);

  Stream<Either<Failure, List<AttendanceModel>>> getAttendance(NoParam params);
}
