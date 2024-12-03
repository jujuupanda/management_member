import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/shared/param/no_param.dart';
import '../../../../core/shared/use_case/stream_use_case.dart';
import '../repositories/manage_attendance_repository.dart';

class GetAllAttendanceUseCase
    extends StreamUseCase<Map<String, dynamic>, NoParam> {
  ManageAttendanceRepository repository;

  GetAllAttendanceUseCase(this.repository);

  @override
  Stream<Either<Failure, Map<String, dynamic>>> call(NoParam params) {
    return repository.getAllAttendance(params);
  }
}
