import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../error/failure.dart';
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
      return JWTFailure("Token kadaluarsa");
    } on JWTException {
      return JWTFailure("Token salah");
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

  //get jwt payload
  jwtPayload() async {
    final jwtToken = await SecureStorageService().getToken();
    if (jwtToken is JWTFailure) {
      return jwtToken;
    }
    final jwtPayload = await TokenService().verifyToken(jwtToken!);
    if (jwtPayload is JWTFailure) {
      return jwtPayload;
    }
    return jwtPayload;
  }

  //get username by token
  jwtPayloadUsername() async {
    final payload = await jwtPayload();
    if (payload is JWTFailure) {
      return payload;
    }
    final payloadUsername = payload.payload["username"].toString();

    return payloadUsername;
  }

  //get role by token
  jwtPayloadRole() async {
    final payload = await jwtPayload();
    if (payload is JWTFailure) {
      return payload;
    }
    final payloadRole = payload.payload["role"].toString();

    return payloadRole;
  }
}
