import '../../../../core/error/failure.dart';
import '../../../../core/shared/entity/blank_entity.dart';
import '../../domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AuthEntity>> login(params) async {
    final userLoggedIn = await remoteDataSource.login(params);
    return userLoggedIn.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, BlankEntity>> logout(params) async {
    final userLogout = await remoteDataSource.logout(params);
    return userLogout.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, BlankEntity>> loginChecker(params) async {
    final loginChecked = await remoteDataSource.loginChecker(params);
    return loginChecked.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
