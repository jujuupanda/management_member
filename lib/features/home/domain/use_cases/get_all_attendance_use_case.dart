import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/shared/param/no_param.dart';
import '../../../../core/shared/use_case/stream_use_case.dart';
import '../../../attendance/domain/entities/attendance_entity.dart';
import '../repositories/manage_attendance_repository.dart';

class GetAllAttendanceUseCase
    extends StreamUseCase<List<AttendanceEntity>, NoParam> {
  ManageAttendanceRepository repository;

  GetAllAttendanceUseCase(this.repository);

  @override
  Stream<Either<Failure, List<AttendanceEntity>>> call(NoParam params) {
    return repository.getAllAttendance(params);
  }
}
