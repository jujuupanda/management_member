import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/shared/entity/blank_entity.dart';
import '../../../../core/shared/use_case/future_use_case.dart';
import '../../../login/data/models/auth_model.dart';
import '../../data/models/user_model.dart';
import '../repositories/profile_repository.dart';

class AddUserUseCase extends FutureUseCase<BlankEntity, AddUserParam> {
  ProfileRepository repository;

  AddUserUseCase(this.repository);

  @override
  Future<Either<Failure, BlankEntity>> call(AddUserParam params) async {
    return await repository.addUser(params);
  }
}

class AddUserParam extends Equatable {
  final UserModel user;
  final AuthModel auth;

  const AddUserParam(this.user, this.auth);

  @override
  List<Object?> get props => [user, auth];
}
