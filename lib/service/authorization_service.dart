import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<String?> getAuthorizationToken() async {
    return await storage.read(key: 'authorization_token');
  }

  static Future<void> setAuthorizationToken(String authorizationToken) async {
    await storage.write(key: 'authorization_token', value: authorizationToken);
  }

  static Future<void> logout() async {
    await storage.delete(key: 'authorization_token');
  }

  static Future<bool> isUserLoggedIn() async{
    return storage.containsKey(key: 'authorization_token');
  }
}
