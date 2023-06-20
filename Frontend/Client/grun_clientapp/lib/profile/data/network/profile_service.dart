import '../../../utils/services/secure_storage_service.dart';
import 'profile_client.dart';
import 'response/user_dto.dart';

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

  static Future<String> getOrders() async {
    final token = await SecureStorageService.getToken();
    return await ProfileClient.getOrders(token: token);
  }

  static logout() async {
    await SecureStorageService.deleteToken();
  }
}
