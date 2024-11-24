import '../../../../core/error/failure.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/password_service.dart';
import '../../../../core/services/token_service.dart';
import '../../../../core/shared/model/blank_model.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../../login/data/models/auth_model.dart';
import '../../domain/use_cases/add_user_use_case.dart';
import '../../domain/use_cases/change_password_use_case.dart';
import '../../domain/use_cases/edit_profile_use_case.dart';
import '../models/user_model.dart';
import 'package:dartz/dartz.dart';

import 'profile_data_source.dart';

class ProfileRemoteDataSource extends ProfileDataSource {
  final firebaseDB = DatabaseService().firebaseFirestore;
  final supabaseStorage = DatabaseService().supabaseStorage;

  @override
  Future<Either<Failure, UserModel>> getProfile(NoParam params) async {
    try {
      final payloadUsername = await TokenService().jwtPayloadUsername();
      final docRef = await firebaseDB
          .collection("users")
          .where(
            "username",
            isEqualTo: payloadUsername.toLowerCase(),
          )
          .get();
      if (docRef.docs.isNotEmpty) {
        final resultUser = UserModel.fromJson(docRef.docs.first.data());
        return Right(resultUser);
      }
      return Left(ServerFailure("Data pengguna tidak ditemukan"));
    } catch (e) {
      return Left(ServerFailure("Terjadi kesalahan saat mencari data"));
    }
  }

  @override
  Future<Either<Failure, BlankModel>> addUser(AddUserParam params) async {
    try {
      final docRef = await firebaseDB
          .collection("users")
          .where("username", isEqualTo: params.user.username)
          .get();
      if (docRef.docs.isNotEmpty) {
        return Left(ServerFailure("Nama pengguna sudah digunakan"));
      }
      await firebaseDB.collection("users").add(params.user.toJson());
      await firebaseDB.collection("logins").add(params.auth.toJson());
      return Right(BlankModel());
    } catch (e) {
      return Left(ServerFailure("Terjadi kesalahan saat menambahkan data"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> editProfile(
      EditProfileParam params) async {
    try {
      final payloadUsername = await TokenService().jwtPayloadUsername();
      return await firebaseDB
          .collection("users")
          .where("username", isEqualTo: payloadUsername.toLowerCase())
          .get()
          .then(
        (value) async {
          final docRef = firebaseDB.collection("users").doc(
                value.docs.first.id,
              );
          await docRef.update(params.user.toJson());
          final userEdited = await docRef.get();
          return Right(UserModel.fromJson(userEdited.data()!));
        },
      );
    } catch (e) {
      return Left(ServerFailure("Terjadi kesalahan saat mengubah profil"));
    }
  }

  @override
  Future<Either<Failure, BlankModel>> changePassword(
      ChangePasswordParam params) async {
    try {
      final payloadUsername = await TokenService().jwtPayloadUsername();
      final docRef = firebaseDB.collection("logins");
      final responseLogin = await docRef
          .where(
            "username",
            isEqualTo: payloadUsername.toLowerCase(),
          )
          .get();
      if (responseLogin.docs.isNotEmpty) {
        final dataLogin = AuthModel.fromJson(responseLogin.docs.first.data());
        final oldPasswordMatch = PasswordService().oldPasswordMatcher(
          dataLogin.password,
          params.oldPassword,
        );
        if (oldPasswordMatch) {
          final newPasswordHashed =
              PasswordService().hashPassword(params.newPassword);
          final newPasswordMatch = PasswordService()
              .newPasswordMatcher(params.oldPassword, params.newPassword);
          if (!newPasswordMatch) {
            await docRef
                .doc(responseLogin.docs.first.id)
                .update({"password": newPasswordHashed});
            return Right(BlankModel());
          }
          return Left(ServerFailure("Kata sandi baru tidak boleh sama dengan yang lama"));
        }
        return Left(ServerFailure("Kata sandi lama tidak cocok"));
      }
      return Left(ServerFailure("Pengguna tidak ditemukan"));
    } catch (e) {
      return Left(ServerFailure("Terjadi kesalahan saat mengubah profil"));
    }
  }
}
