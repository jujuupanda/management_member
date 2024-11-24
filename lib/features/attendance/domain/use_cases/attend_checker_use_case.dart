import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/shared/param/no_param.dart';
import '../../../../core/shared/use_case/stream_use_case.dart';
import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class AttendCheckerUseCase extends StreamUseCase<AttendanceEntity, NoParam> {
  AttendanceRepository repository;

  AttendCheckerUseCase(this.repository);

  @override
  Stream<Either<Failure, AttendanceEntity>> call(params)  {
    return  repository.attendChecker(params);
  }
}
