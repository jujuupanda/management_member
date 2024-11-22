import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/shared/use_case/future_use_case.dart';
import '../../data/models/user_model.dart';
import '../entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class EditProfileUseCase extends FutureUseCase<UserEntity, EditProfileParam> {
  ProfileRepository repository;

  EditProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(params) async {
    return await repository.editProfile(params);
  }
}

class EditProfileParam extends Equatable {
  final UserModel user;

  const EditProfileParam(this.user);

  @override
  List<Object?> get props => [user];
}
