import 'package:grun_mobileapp/profile/data/network/profile_service.dart';
import 'package:grun_mobileapp/profile/data/network/response/user_dto.dart';

class ProfileRepository {
  static Future<String> getUser() async {
    return await ProfileService.getUser();
  }

  static Future<String> changePassword(
      {required String oldPassword, required String newPassword}) async {
    return await ProfileService.changePassword(
        oldPassword: oldPassword, newPassword: newPassword);
  }

  static Future<String> updateUser({required UserDTO user}) async {
    return await ProfileService.updateUser(user: user);
  }

  static Future<String> getOrders() async {
    return await ProfileService.getOrders();
  }

  static logout() async {
    await ProfileService.logout();
  }
}
