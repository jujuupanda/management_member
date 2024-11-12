import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/use_case/future_use_case.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase extends FutureUseCase<AuthEntity, LoginParam> {
  AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(params) async {
    return await repository.login(params);
  }
}

class LoginParam extends Equatable {
  final String username;
  final String password;

  const LoginParam(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}
