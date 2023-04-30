import 'package:grun_mobileapp/register/data/datastore/secure_storage_service.dart';
import 'package:grun_mobileapp/register/data/network/register_client.dart';
import 'package:grun_mobileapp/register/domain/entities/register_user_dto.dart';

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
