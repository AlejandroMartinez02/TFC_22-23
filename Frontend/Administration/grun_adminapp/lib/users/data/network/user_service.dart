import 'package:grun_adminapp/users/domain/entities/user_dto.dart';

import '../../../utils/services/secure_storage_service.dart';
import 'user_client.dart';

class UserService {
  static Future<String> getUsers() async {
    final token = await SecureStorageService.getToken();
    return UserClient.getUsers(token: token);
  }

  static Future<String> updateUser({required UserDTO updatedUser}) async {
    final token = await SecureStorageService.getToken();
    return UserClient.updateUser(updateUser: updatedUser, token: token);
  }

  static Future<String> deleteUser({required String id}) async {
    final token = await SecureStorageService.getToken();
    return UserClient.deleteUser(id: id, token: token);
  }
}
