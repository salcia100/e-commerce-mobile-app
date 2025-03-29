import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();

  // Save Token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: "auth_token", value: token);
  }

  // Get Token
  static Future<String?> getToken() async {
    return await _storage.read(key: "auth_token");
  }

  // Delete Token (Logout)
  static Future<void> deleteToken() async {
    await _storage.delete(key: "auth_token");
  }
}
