import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/use_case/future_use_case.dart';
import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class CheckOutUseCase extends FutureUseCase<AttendanceEntity, CheckOutParam> {
  AttendanceRepository repository;

  CheckOutUseCase(this.repository);

  @override
  Future<Either<Failure, AttendanceEntity>> call(params) async {
    return await repository.checkOut(params);
  }
}

class CheckOutParam extends Equatable {
  @override
  List<Object?> get props => [];
}
