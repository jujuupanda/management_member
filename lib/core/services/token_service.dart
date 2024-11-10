import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'secure_storage_service.dart';

class TokenService {
  final firebaseMessaging = FirebaseMessaging.instance;

  //sign jwt with expiration 7 days
  jwtWithExpiration(String username, String role) {
    final jwt = JWT(
      {
        'username': username,
        'role': role,
      },
    );

    final token = jwt.sign(
      SecretKey('kenArok'),
      expiresIn: const Duration(days: 7),
    );

    return token;
  }

  //verify jwt
  verifyToken(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey('kenArok'));
      return jwt;
    } on JWTExpiredException {
      return "Expired";
    } on JWTException {
      return "Token invalid";
    }
  }

  //fcm token
  fcmToken() async {
    try {
      final fcmToken = await firebaseMessaging.getToken();
      return fcmToken;
    } catch (e) {
      throw Exception(e);
    }
  }

  //get username by token
  jwtPayloadUsername() async {
    final jwtToken = await SecureStorageService().getToken();
    final jwtPayload = await TokenService().verifyToken(jwtToken!);
    final payloadUsername = jwtPayload.payload["username"].toString();
    return payloadUsername;
  }

  //get role by token
  jwtPayloadRole() async {
    final jwtToken = await SecureStorageService().getToken();
    final jwtPayload = await TokenService().verifyToken(jwtToken!);
    final payloadUsername = jwtPayload.payload["role"].toString();
    return payloadUsername;
  }
}
