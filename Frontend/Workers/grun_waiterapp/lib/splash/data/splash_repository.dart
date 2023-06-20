import 'network/splash_service.dart';

class SplashRepository {
  static Future<bool> checkToken() async {
    return await SplashService.checkToken();
  }

  static Future<String?> getToken() async {
    return await SplashService.getToken();
  }
}
