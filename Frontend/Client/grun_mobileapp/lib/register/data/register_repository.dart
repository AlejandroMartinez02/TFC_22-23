import 'package:grun_mobileapp/register/data/network/register_service.dart';
import 'package:grun_mobileapp/register/domain/entities/register_user_dto.dart';

class RegisterRepository {
  static Future<String?> register(RegisterUserDTO user) async {
    return await RegisterService.register(user);
  }
}
