import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/services/token_service.dart';
import '../../../../core/shared/model/blank_model.dart';
import '../../../profile/data/models/user_model.dart';
import '../models/auth_model.dart';

import 'auth_data_source.dart';

class AuthRemoteDataSource extends AuthDataSource {
  final firebaseDB = FirebaseService().firebaseFirestore;

  @override
  Future<Either<Failure, AuthModel>> login(params) async {
    try {
      final responseLogin = await firebaseDB
          .collection("logins")
          .where("username", isEqualTo: params.username.toLowerCase())
          .get();

      if (responseLogin.docs.isNotEmpty) {
        final resultLogin = AuthModel.fromJson(responseLogin.docs.first.data());
        if (resultLogin.password == params.password) {
          final jwtToken = await TokenService().jwtWithExpiration(
            resultLogin.username,
            resultLogin.role,
          );
          final fcmToken = await TokenService().fcmToken();
          await firebaseDB
              .collection("logins")
              .where("username", isEqualTo: params.username.toLowerCase())
              .get()
              .then(
            (value) async {
              await firebaseDB
                  .collection("logins")
                  .doc(value.docs.first.id)
                  .update({
                "jwtToken": jwtToken,
                "fcmToken": fcmToken,
              });
              // await firebaseDB
              //     .collection("users")
              //     .where(
              //       "username",
              //       isEqualTo: params.username.toLowerCase(),
              //     )
              //     .get()
              //     .then(
              //   (value) async {
              //     final responseUser =
              //         UserModel.fromJson(value.docs.first.data());
              //     await SecureStorageService()
              //         .saveString("activeWork", responseUser.activeWork);
              //   },
              // );
            },
          );
          await SecureStorageService().saveToken(jwtToken);
          return Right(resultLogin);
        }
        return Left(ServerFailure("Kata sandi salah"));
      }
      return Left(ServerFailure("Nama pengguna tidak ditemukan"));
    } catch (e) {
      return Left(ServerFailure("Terjadi kesalahan saat login"));
    }
  }

  @override
  Future<Either<Failure, BlankModel>> logout(params) async {
    try {
      final payloadUsername = await TokenService().jwtPayloadUsername();
      await firebaseDB
          .collection("logins")
          .where(
            "username",
            isEqualTo: payloadUsername.toLowerCase(),
          )
          .get()
          .then(
        (value) async {
          await firebaseDB
              .collection("logins")
              .doc(value.docs.first.id)
              .update({
            "jwtToken": "",
            "fcmToken": "",
          });
        },
      );
      await SecureStorageService().deleteAllData();
      return Right(BlankModel());
    } catch (e) {
      return Left(ServerFailure("Terjadi kesalahan saat logout"));
    }
  }

  @override
  Future<Either<Failure, BlankModel>> loginChecker(params) async {
    try {
      final jwtToken = await SecureStorageService().getToken();
      if (jwtToken != null) {
        final jwt = await TokenService().verifyToken(jwtToken);
        if (jwt is JWTFailure) {
          await SecureStorageService().deleteAllData();
          return Left(CacheFailure(jwt.message));
        }
        return Right(BlankModel());
      }
      return Left(CacheFailure("Token kosong"));
    } catch (e) {
      await SecureStorageService().deleteAllData();
      return Left(CacheFailure("Terjadi kesalahan saat melakukan pengecekan"));
    }
  }
}
