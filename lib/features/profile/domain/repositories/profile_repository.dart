import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../use_cases/get_profile_use_case.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserEntity>> getProfile(ProfileParam params);
}
