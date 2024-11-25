import '../../../../core/error/failure.dart';
import '../../../../core/shared/entity/blank_entity.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/profile_repository.dart';
import '../../domain/use_cases/add_user_use_case.dart';
import '../../domain/use_cases/change_password_use_case.dart';
import '../../domain/use_cases/edit_profile_use_case.dart';
import '../data_sources/profile_data_source.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> getProfile(NoParam params) async {
    final getDataProfile = await remoteDataSource.getProfile(params);
    return getDataProfile.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, BlankEntity>> addUser(AddUserParam params) async {
    final userAdded = await remoteDataSource.addUser(params);
    return userAdded.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> editProfile(
      EditProfileParam params) async {
    final editedProfile = await remoteDataSource.editProfile(params);
    return editedProfile.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, BlankEntity>> changePassword(
      ChangePasswordParam params) async {
    final passwordEdited = await remoteDataSource.changePassword(params);
    return passwordEdited.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
