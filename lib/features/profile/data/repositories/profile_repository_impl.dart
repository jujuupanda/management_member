import '../../../../core/error/failure.dart';
import '../../domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/profile_repository.dart';
import '../../domain/use_cases/get_profile_use_case.dart';
import '../data_sources/profile_remote_data_source.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> getProfile(ProfileParam params) async {
    final getDataProfile = await remoteDataSource.getProfile(params);
    return getDataProfile.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
