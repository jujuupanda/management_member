import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/shared/param/no_param.dart';
import '../../../../core/shared/use_case/stream_use_case.dart';
import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class GetAttendanceUseCase
    extends StreamUseCase<List<AttendanceEntity>, NoParam> {
  AttendanceRepository repository;

  GetAttendanceUseCase(this.repository);

  @override
  Stream<Either<Failure, List<AttendanceEntity>>> call(params) {
    return repository.getAttendance(params);
  }
}
