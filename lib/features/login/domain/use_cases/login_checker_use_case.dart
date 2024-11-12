import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/shared/entity/blank_entity.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../../../core/shared/use_case/future_use_case.dart';
import '../repositories/auth_repository.dart';

class LoginCheckerUseCase extends FutureUseCase<BlankEntity, NoParam> {
  AuthRepository repository;

  LoginCheckerUseCase(this.repository);

  @override
  Future<Either<Failure, BlankEntity>> call(params) async {
    return await repository.loginChecker(params);
  }
}
