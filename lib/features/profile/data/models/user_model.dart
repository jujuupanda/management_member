import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.username,
    required super.fullName,
    required super.status,
    required super.email,
    required super.phone,
    required super.address,
    required super.salary,
  });
}
