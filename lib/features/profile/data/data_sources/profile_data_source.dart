import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/model/blank_model.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../domain/use_cases/add_user_use_case.dart';
import '../../domain/use_cases/edit_profile_use_case.dart';
import '../models/user_model.dart';

abstract class ProfileDataSource {
  Future<Either<Failure, UserModel>> getProfile(NoParam params);

  Future<Either<Failure, BlankModel>> addUser(AddUserParam params);

  Future<Either<Failure, UserModel>> editProfile(EditProfileParam params);

  Future<Either<Failure, String>> uploadImage(NoParam params);
}
