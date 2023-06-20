import '../../data/splash_repository.dart';

class GetTokenUseCase {
  static Future<String?> getToken() async {
    return await SplashRepository.getToken();
  }
}
