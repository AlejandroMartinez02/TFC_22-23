import '../../data/splash_repository.dart';

class CheckTokenUseCase {
  static Future<bool> checkToken() async {
    return await SplashRepository.checkToken();
  }
}
