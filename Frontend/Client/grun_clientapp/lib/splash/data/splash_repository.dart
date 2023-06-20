import 'network/splash_service.dart';

class SplashRepository {
  static Future<bool> checkToken() async {
    return await SplashService.checkToken();
  }
}
