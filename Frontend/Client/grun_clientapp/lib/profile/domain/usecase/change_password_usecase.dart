import 'dart:convert';

import '../../data/profile_repository.dart';

class ChangePasswordUseCase {
  static Future<int> changePassword(
      {required String oldPassword, required String newPassword}) async {
    final response = await ProfileRepository.changePassword(
        oldPassword: oldPassword, newPassword: newPassword);
    final hasChanged = json.decode(response);
    return hasChanged['status'];
  }
}
