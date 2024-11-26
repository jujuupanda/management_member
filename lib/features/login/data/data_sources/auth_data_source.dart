import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/model/blank_model.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../models/auth_model.dart';

import '../../../../core/services/database_service.dart';
import '../../../../core/services/password_service.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/services/token_service.dart';
import '../../../profile/data/models/user_model.dart';

part 'auth_remote_data_source.dart';

abstract class AuthDataSource {
  Future<Either<Failure, AuthModel>> login(LoginParam params);

  Future<Either<Failure, BlankModel>> logout(NoParam params);

  Future<Either<Failure, BlankModel>> loginChecker(NoParam params);
}
