import '../domain/entities/register_user_dto.dart';
import 'network/register_service.dart';

class RegisterRepository {
  static Future<String?> register(RegisterUserDTO user) async {
    return await RegisterService.register(user);
  }
}
