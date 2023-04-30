import 'package:grun_mobileapp/splash/data/network/splash_service.dart';

class SplashRepository {
  static Future<bool> checkToken() async {
    return await SplashService.checkToken();
  }
}
