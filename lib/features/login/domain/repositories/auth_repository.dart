import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/entity/blank_entity.dart';
import '../../../../core/shared/param/no_param.dart';
import '../entities/auth_entity.dart';
import '../use_cases/login_use_case.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> login(LoginParam params);

  Future<Either<Failure, BlankEntity>> logout(NoParam params);

  Future<Either<Failure, BlankEntity>> loginChecker(NoParam params);
}
