import 'dart:convert';

import 'package:crypto/crypto.dart';

class PasswordService {
  String hashPassword(String password) {
    final utf8Encoded = utf8.encode(password);
    final hashedPassword = sha256.convert(utf8Encoded);
    return hashedPassword.toString();
  }

  bool oldPasswordMatcher(String storedPassword, String enteredPassword) {
    final hashedEnteredPassword = hashPassword(enteredPassword);
    if (hashedEnteredPassword == storedPassword) {
      return true;
    } else {
      return false;
    }
  }

  bool newPasswordMatcher(String oldPassword, String newPassword) {
    final hashedOldPassword = hashPassword(oldPassword);
    final hashedNewPassword = hashPassword(newPassword);
    if (hashedOldPassword == hashedNewPassword) {
      return true;
    } else {
      return false;
    }
  }
}
