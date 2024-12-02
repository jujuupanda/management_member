import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../../attendance/data/models/attendance_model.dart';

abstract class ManageAttendanceDataSource {
  Stream<Either<Failure, List<AttendanceModel>>> getAllAttendance(
      NoParam params);
}
