import '../domain/entities/user_dto.dart';
import 'network/user_service.dart';

class UserRepository {
  static Future<String> getUsers() async {
    return UserService.getUsers();
  }

  static Future<String> updateUser({required UserDTO updatedUser}) async {
    return UserService.updateUser(updatedUser: updatedUser);
  }

  static Future<String> deleteUser({required String id}) async {
    return UserService.deleteUser(id: id);
  }
}
