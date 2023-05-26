import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    show FlutterSecureStorage;

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  static Future<void> addToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  static Future<String> getToken() async {
    return await _storage.read(key: 'token') ?? '';
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
  }
}
