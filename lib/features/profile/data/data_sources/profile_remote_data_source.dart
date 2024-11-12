import '../../../../core/error/failure.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../core/services/token_service.dart';
import '../models/user_model.dart';
import 'package:dartz/dartz.dart';

import 'profile_data_source.dart';

class ProfileRemoteDataSource extends ProfileDataSource {
  final firebaseDB = FirebaseService().firebaseFirestore;

  @override
  Future<Either<Failure, UserModel>> getProfile(params) async {
    try {
      final payloadUsername = await TokenService().jwtPayloadUsername();
      final responseUser = await firebaseDB
          .collection("users")
          .where(
            "username",
            isEqualTo: payloadUsername.toLowerCase(),
          )
          .get();
      if (responseUser.docs.isNotEmpty) {
        final resultUser = UserModel.fromJson(responseUser.docs.first.data());
        return Right(resultUser);
      }
      return Left(ServerFailure("Data pengguna tidak ditemukan"));
    } catch (e) {
      return Left(ServerFailure("Terjadi kesalahan saat mencari data"));
    }
  }
}
