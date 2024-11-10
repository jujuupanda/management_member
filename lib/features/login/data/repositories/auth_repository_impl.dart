import '../../../../core/error/failure.dart';
import '../../../../core/shared/entity/blank_entity.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AuthEntity>> login(LoginParam params) async {
    final userLoggedIn = await remoteDataSource.login(params);
    return userLoggedIn.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, BlankEntity>> logout(NoParam params) async {
    final userLogout = await remoteDataSource.logout(params);
    return userLogout.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, BlankEntity>> loginChecker(NoParam params) async {
    final loginChecked = await remoteDataSource.loginChecker(params);
    return loginChecked.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
