import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/use_case/future_use_case.dart';
import '../../data/models/attendance_model.dart';
import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class CheckInUseCase extends FutureUseCase<AttendanceEntity, CheckInParam> {
  AttendanceRepository repository;

  CheckInUseCase(this.repository);

  @override
  Future<Either<Failure, AttendanceEntity>> call(params) async {
    return await repository.checkIn(params);
  }
}

class CheckInParam extends Equatable {
  final AttendanceModel attendance;

  const CheckInParam(this.attendance);

  @override
  List<Object?> get props => [attendance];
}
