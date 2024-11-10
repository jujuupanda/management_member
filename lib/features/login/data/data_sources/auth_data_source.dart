import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/model/blank_model.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../models/auth_model.dart';

abstract class AuthDataSource {
  Future<Either<Failure, AuthModel>> login(LoginParam params);

  Future<Either<Failure, BlankModel>> logout(NoParam params);

  Future<Either<Failure, BlankModel>> loginChecker(NoParam params);
}
