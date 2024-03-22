import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mss_e_learning/util/app_constants.dart';

class AuthService {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<String?> getAuthorizationToken() async {
    return await storage.read(key: AppConstants.authStorage);
  }

  static Future<void> setAuthorizationToken(String authorizationToken) async {
    await storage.write(key: AppConstants.authStorage, value: authorizationToken);
  }

  static Future<void> logout() async {
    await storage.delete(key: AppConstants.authStorage);
  }

  static Future<bool> isUserLoggedIn() async{
    return storage.containsKey(key: AppConstants.authStorage);
  }
}
