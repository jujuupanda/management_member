import 'dart:convert';

import 'package:crypto/crypto.dart';

class PasswordService {
  String hashPassword(String password) {
    final utf8Encoded = utf8.encode(password);
    final hashedPassword = sha256.convert(utf8Encoded);
    return hashedPassword.toString();
  }

  bool passwordMatcher(String storedPassword, String enteredPassword) {
    final hashedEnteredPassword = hashPassword(enteredPassword);
    if (hashedEnteredPassword == storedPassword) {
      return true;
    } else {
      return false;
    }
  }
}
