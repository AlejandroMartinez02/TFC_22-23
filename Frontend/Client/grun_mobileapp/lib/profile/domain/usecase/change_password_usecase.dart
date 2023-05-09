import 'dart:convert';

import 'package:grun_mobileapp/profile/data/profile_repository.dart';

class ChangePasswordUseCase {
  static Future<int> changePassword(
      {required String oldPassword, required String newPassword}) async {
    final response = await ProfileRepository.changePassword(
        oldPassword: oldPassword, newPassword: newPassword);
    final hasChanged = json.decode(response);
    return hasChanged['status'];
  }
}
