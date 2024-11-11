import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/use_case/future_use_case.dart';
import '../entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class GetProfileUseCase extends FutureUseCase<UserEntity, ProfileParam> {
  ProfileRepository repository;

  GetProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(ProfileParam params) async {
    return await repository.getProfile(params);
  }
}

class ProfileParam extends Equatable {
  final String username;

  const ProfileParam(this.username);

  @override
  List<Object?> get props => [username];
}
