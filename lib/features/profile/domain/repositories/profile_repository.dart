import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/entity/blank_entity.dart';
import '../../../../core/shared/param/no_param.dart';
import '../entities/user_entity.dart';
import '../use_cases/add_user_use_case.dart';
import '../use_cases/edit_profile_use_case.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserEntity>> getProfile(NoParam params);

  Future<Either<Failure, BlankEntity>> addUser(AddUserParam params);

  Future<Either<Failure, UserEntity>> editProfile(EditProfileParam params);
}
