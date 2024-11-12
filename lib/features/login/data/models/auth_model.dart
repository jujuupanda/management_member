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
    return AuthModel(
      username: json["username"],
      password: json["password"],
      role: json["role"],
      jwtToken: json["jwt_token"],
      fcmToken: json["fcm_token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "role": role,
      "jwt_token": jwtToken,
      "fcm_token": fcmToken,
    };
  }
}
