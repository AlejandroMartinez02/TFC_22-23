import 'dart:convert';

import '../../data/network/response/user_dto.dart';
import '../../data/profile_repository.dart';

class UpdateUserUseCase {
  static Future<int> updateUser({required UserDTO user}) async {
    final body = await ProfileRepository.updateUser(user: user);
    final response = json.decode(body);
    return response['status'];
  }
}
