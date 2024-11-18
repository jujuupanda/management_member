import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../../../core/shared/use_case/future_use_case.dart';
import '../entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class GetProfileUseCase extends FutureUseCase<UserEntity, NoParam> {
  ProfileRepository repository;

  GetProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParam params) async {
    return await repository.getProfile(params);
  }
}
