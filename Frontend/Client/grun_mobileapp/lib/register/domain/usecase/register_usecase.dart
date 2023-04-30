import 'package:grun_mobileapp/register/data/register_repository.dart';
import 'package:grun_mobileapp/register/domain/entities/register_user_dto.dart';

class RegisterUseCase {
  static Future<String?> register(RegisterUserDTO user) async {
    return await RegisterRepository.register(user);
  }
}
