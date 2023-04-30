import 'package:grun_mobileapp/login/data/network/login_service.dart';
import 'package:grun_mobileapp/login/domain/entity/user_dto.dart';

class LoginRepository {
  static Future<String?> login(String email, String password) async {
    return await LoginService.login(UserDTO(email: email, password: password));
  }
}
