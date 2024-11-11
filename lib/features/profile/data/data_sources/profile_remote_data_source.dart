import '../../../../core/error/failure.dart';
import '../../domain/use_cases/get_profile_use_case.dart';
import '../models/user_model.dart';
import 'package:dartz/dartz.dart';

import 'profile_data_source.dart';

class ProfileRemoteDataSource extends ProfileDataSource {
  @override
  Future<Either<Failure, UserModel>> getProfile(ProfileParam params) async  {
    // TODO: implement getProfile
    throw UnimplementedError();
  }
}