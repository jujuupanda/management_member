import '../../domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  AuthModel({
    required super.username,
    required super.password,
    required super.role,
    required super.jwtToken,
    required super.fcmToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final username = json["username"];
    final password = json["password"];
    final role = json["role"];
    final jwtToken = json["jwtToken"];
    final fcmToken = json["fcmToken"];

    final authModel = AuthModel(
      username: username,
      password: password,
      role: role,
      jwtToken: jwtToken,
      fcmToken: fcmToken,
    );

    return authModel;
  }
}
