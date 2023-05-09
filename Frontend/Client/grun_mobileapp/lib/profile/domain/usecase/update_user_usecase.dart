import 'dart:convert';

import 'package:grun_mobileapp/profile/data/profile_repository.dart';

import '../../data/network/response/user_dto.dart';

class UpdateUserUseCase {
  static Future<int> updateUser({required UserDTO user}) async {
    final body = await ProfileRepository.updateUser(user: user);
    final response = json.decode(body);
    return response['status'];
  }
}
