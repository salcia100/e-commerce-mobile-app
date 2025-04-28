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

    // Save User ID
  static Future<void> saveUserId(String userId) async {
    await _storage.write(key: "user_id", value: userId);
  }

  // Get User ID
  static Future<int?> getUserId() async {
    String? userIdString = await _storage.read(key: "user_id");
    if (userIdString != null) {
      return int.tryParse(userIdString);  
    }
    return null;
  }

  // Delete Token (Logout)
  static Future<void> deleteToken() async {
    await _storage.delete(key: "auth_token");
  }
}
