import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../../attendance/domain/entities/attendance_entity.dart';

abstract class ManageAttendanceRepository {
  Stream<Either<Failure, List<AttendanceEntity>>> getAllAttendance(
      NoParam params);
}
