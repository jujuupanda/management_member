import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/shared/param/no_param.dart';
import '../../../../core/shared/use_case/future_use_case.dart';
import '../repositories/profile_repository.dart';

class UploadImageProfileUseCase extends FutureUseCase<String, NoParam> {
  ProfileRepository repository;

  UploadImageProfileUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(NoParam params) async {
    return await repository.uploadImage(params);
  }
}
