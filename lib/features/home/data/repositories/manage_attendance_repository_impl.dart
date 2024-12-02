import '../../../../core/error/failure.dart';
import '../../../../core/shared/param/no_param.dart';
import 'package:dartz/dartz.dart';

import '../../../attendance/domain/entities/attendance_entity.dart';
import '../../domain/repositories/manage_attendance_repository.dart';
import '../data_sources/manage_attendance_remote_data_source.dart';

class ManageAttendanceRepositoryImpl extends ManageAttendanceRepository {
  ManageAttendanceRemoteDataSource remoteDataSource;

  ManageAttendanceRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Stream<Either<Failure, List<AttendanceEntity>>> getAllAttendance(
      NoParam params) {
    final allAttendances = remoteDataSource.getAllAttendance(params);
    return allAttendances;
  }
}
