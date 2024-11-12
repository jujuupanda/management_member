import '../../../../core/error/failure.dart';
import '../../domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/profile_repository.dart';
import '../data_sources/profile_remote_data_source.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> getProfile(params) async {
    final getDataProfile = await remoteDataSource.getProfile(params);
    return getDataProfile.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
