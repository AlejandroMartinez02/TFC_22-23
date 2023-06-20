import '../../data/register_repository.dart';
import '../entities/register_user_dto.dart';

class RegisterUseCase {
  static Future<String?> register(RegisterUserDTO user) async {
    return await RegisterRepository.register(user);
  }
}
