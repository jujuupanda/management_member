import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/param/no_param.dart';
import '../models/user_model.dart';

abstract class ProfileDataSource {
  Future<Either<Failure, UserModel>> getProfile(NoParam params);
}
