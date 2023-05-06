import '../domain/entity/user_dto.dart';
import 'network/login_service.dart';

class LoginRepository {
  static Future<String?> login(String email, String password) async {
    return await LoginService.login(UserDTO(email: email, password: password));
  }
}
