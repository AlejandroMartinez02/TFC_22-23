import '../../../utils/services/secure_storage_service.dart';
import '../../domain/entity/user_dto.dart';
import 'login_client.dart';

class LoginService {
  static Future<String?> login(UserDTO user) async {
    final response = await LoginClient.login(user);
    if (response.status == "200") {
      if (response.worker.role == 'Waiter') {
        await SecureStorageService.addToken(response.token);
        return null;
      }
      return '404';
    }
    return response.status;
  }
}
