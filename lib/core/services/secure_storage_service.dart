export 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../error/failure.dart';

class SecureStorageService {
  final storage = const FlutterSecureStorage();

  // Menyimpan token
  Future<void> saveToken(String token) async {
    await storage.write(key: 'jwtToken', value: token);
  }

  // Mengambil token
  getToken() async {
    final token = await storage.read(key: 'jwtToken');
    if (token != null) {
      return token;
    } else {
      return JWTFailure("Token kosong");
    }
  }

  // Menghapus token
  Future<void> deleteToken() async {
    await storage.delete(key: 'jwtToken');
  }

  // Menghapus semua data
  Future<void> deleteAllData() async {
    await storage.deleteAll();
  }

  Future<void> saveString(String name, String value) async {
    await storage.write(key: name, value: value);
  }

  Future<String?> retrieveString(String name) async {
    return await storage.read(key: name);
  }
}
