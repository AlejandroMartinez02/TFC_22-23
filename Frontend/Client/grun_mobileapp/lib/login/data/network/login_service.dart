import 'package:grun_mobileapp/login/data/datastore/secure_storage_service.dart';
import 'package:grun_mobileapp/login/data/network/login_client.dart';
import 'package:grun_mobileapp/login/domain/entity/user_dto.dart';

class LoginService {
  static Future<String?> login(UserDTO user) async {
    final response = await LoginClient.login(user);
    if (response.status == "200") {
      SecureStorageService.addToken(response.token);
      return null;
    }
    return response.status;
  }
}
