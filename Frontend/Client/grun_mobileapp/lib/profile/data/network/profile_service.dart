import 'package:grun_mobileapp/profile/data/network/profile_client.dart';
import 'package:grun_mobileapp/profile/data/network/response/user_dto.dart';
import 'package:grun_mobileapp/register/data/datastore/secure_storage_service.dart';

class ProfileService {
  static Future<String> getUser() async {
    final token = await SecureStorageService.getToken();
    return await ProfileClient.getUser(token: token);
  }

  static Future<String> changePassword(
      {required String oldPassword, required String newPassword}) async {
    final token = await SecureStorageService.getToken();
    return await ProfileClient.changePassword(
        oldPassword: oldPassword, newPassword: newPassword, token: token);
  }

  static Future<String> updateUser({required UserDTO user}) async {
    final token = await SecureStorageService.getToken();
    return await ProfileClient.updateUser(user: user, token: token);
  }
}
