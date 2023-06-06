import '../../../utils/services/secure_storage_service.dart';
import '../../domain/entities/register_user_dto.dart';
import 'register_client.dart';

class RegisterService {
  static Future<String?> register(RegisterUserDTO user) async {
    final response = await RegisterClient.register(user);
    if (response.status == "201") {
      SecureStorageService.addToken(response.token);
      return null;
    }
    return response.status;
  }
}
