import '../../domain/entity/user_dto.dart';
import '../datastore/secure_storage_service.dart';
import 'login_client.dart';

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
