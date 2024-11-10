import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/entity/blank_entity.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../../../core/shared/use_case/future_use_case.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase extends FutureUseCase<BlankEntity, NoParam> {
  AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, BlankEntity>> call(NoParam params) async {
    return await repository.logout(params);
  }
}
