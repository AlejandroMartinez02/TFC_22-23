import '../../data/login_repository.dart';

class LoginUseCase {
  static Future<String?> login(String email, String password) async {
    return await LoginRepository.login(email, password);
  }
}
