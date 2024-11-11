import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/use_cases/get_profile_use_case.dart';
import '../models/user_model.dart';

abstract class ProfileDataSource {
  Future<Either<Failure, UserModel>> getProfile(ProfileParam params);
}
