import 'dart:convert';

import '../../data/user_respository.dart';
import '../entities/user_dto.dart';

class UpdateUserUseCase {
  static Future<int> updateUser({required UserDTO updatedUser}) async {
    final response = await UserRepository.updateUser(updatedUser: updatedUser);
    return json.decode(response)['status'];
  }
}
