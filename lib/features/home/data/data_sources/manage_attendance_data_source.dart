import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/param/no_param.dart';

abstract class ManageAttendanceDataSource {
  Stream<Either<Failure, Map<String, dynamic>>> getAllAttendance(
      NoParam params);
}
