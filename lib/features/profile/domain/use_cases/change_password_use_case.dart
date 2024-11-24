import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/shared/entity/blank_entity.dart';
import '../../../../core/shared/use_case/future_use_case.dart';
import '../repositories/profile_repository.dart';

class ChangePasswordUseCase
    extends FutureUseCase<BlankEntity, ChangePasswordParam> {
  ProfileRepository repository;

  ChangePasswordUseCase(this.repository);

  @override
  Future<Either<Failure, BlankEntity>> call(ChangePasswordParam params) async {
    return await repository.changePassword(params);
  }
}

class ChangePasswordParam extends Equatable {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordParam(this.oldPassword, this.newPassword);

  @override
  List<Object?> get props => [oldPassword, newPassword];
}
